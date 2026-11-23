import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../l10n/tr.dart';

enum FamilyControlsAuthorization {
  approved,
  denied,
  notDetermined,
  unavailable,
  unknown;

  static FamilyControlsAuthorization fromRaw(String? raw) {
    switch (raw) {
      case 'approved':
        return FamilyControlsAuthorization.approved;
      case 'denied':
        return FamilyControlsAuthorization.denied;
      case 'notDetermined':
        return FamilyControlsAuthorization.notDetermined;
      case 'unavailable':
        return FamilyControlsAuthorization.unavailable;
      default:
        return FamilyControlsAuthorization.unknown;
    }
  }

  bool get isAuthorized => this == FamilyControlsAuthorization.approved;
}

class SelectionCounts {
  const SelectionCounts({
    required this.applicationCount,
    required this.categoryCount,
    required this.webDomainCount,
    this.applicationNames = const [],
  });

  final int applicationCount;
  final int categoryCount;
  final int webDomainCount;
  final List<String> applicationNames;

  int get total => applicationCount + categoryCount + webDomainCount;

  static SelectionCounts? fromChannel(Object? raw) {
    if (raw is! Map) return null;
    int read(String key) {
      final value = raw[key];
      if (value is int) return value;
      if (value is num) return value.toInt();
      return 0;
    }

    return SelectionCounts(
      applicationCount: read('applicationCount'),
      categoryCount: read('categoryCount'),
      webDomainCount: read('webDomainCount'),
      applicationNames: _stringList(raw['applicationNames']),
    );
  }
}

List<String> _stringList(Object? raw) {
  if (raw is! List) return const [];
  return [
    for (final item in raw)
      if (item is String && item.isNotEmpty) item,
  ];
}

class FocusShieldException implements Exception {
  const FocusShieldException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'FocusShieldException($code, $message)';
}

String describeShieldFailure(FocusShieldException exception) {
  switch (exception.code) {
    case 'NOT_AUTHORIZED':
      return tr('shield_not_authorized');
    case 'EMPTY_SELECTION':
      return tr('shield_empty');
    case 'UNAVAILABLE':
      return tr('shield_unavailable');
    case 'NO_PRESENTER':
      return tr('shield_no_presenter');
    case 'DEVICE_ACTIVITY':
      return exception.message.isEmpty
          ? tr('shield_device_activity')
          : exception.message;
    case 'LIST_IN_USE':
      return tr('shield_list_in_use');
    default:
      return exception.message.isEmpty
          ? tr('shield_generic')
          : exception.message;
  }
}

/// True on Android, where blocking uses an accessibility service.
bool get blocksWithAccessibility => !kIsWeb && Platform.isAndroid;

/// Talks to the system that shields apps during a focus session.
///
/// iOS uses Family Controls. Android uses an accessibility service that
/// notices which app is open and shows the block screen.
class FocusShieldBridge {
  FocusShieldBridge({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('foqui/focus_shield');

  final MethodChannel _channel;

  bool get _canShield => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// True when the apps for a list are stored on this device and can be checked.
  bool get storesSelections => _canShield;

  Future<FamilyControlsAuthorization> status() async {
    if (!_canShield) return FamilyControlsAuthorization.unavailable;
    try {
      final raw = await _channel.invokeMethod<String>('familyControlsStatus');
      return FamilyControlsAuthorization.fromRaw(raw);
    } catch (error, stack) {
      debugPrint('familyControlsStatus failed: $error\n$stack');
      return FamilyControlsAuthorization.unknown;
    }
  }

  Future<FamilyControlsAuthorization> requestAuthorization() async {
    if (!_canShield) return FamilyControlsAuthorization.unavailable;
    try {
      final raw = await _channel.invokeMethod<String>(
        'requestFamilyControlsAuthorization',
      );
      return FamilyControlsAuthorization.fromRaw(raw);
    } catch (error, stack) {
      debugPrint('requestFamilyControlsAuthorization failed: $error\n$stack');
      return status();
    }
  }

  Future<bool> openSystemSettings() async {
    if (!_canShield) return false;
    try {
      return await _channel.invokeMethod<bool>('openSystemSettings') ?? false;
    } catch (error, stack) {
      debugPrint('openSystemSettings failed: $error\n$stack');
      return false;
    }
  }

  /// Opens the system app picker. Returns null when the picker is dismissed
  /// without a choice. The selection stays in a draft until [commitSelection].
  Future<SelectionCounts?> presentAppPicker(String listId) async {
    if (!_canShield) {
      throw const FocusShieldException('UNAVAILABLE', '');
    }
    try {
      final raw = await _channel.invokeMethod<Object?>('presentAppPicker', {
        'listId': listId,
      });
      if (raw == null) return null;
      return SelectionCounts.fromChannel(raw);
    } on PlatformException catch (error) {
      throw FocusShieldException(error.code, error.message ?? '');
    }
  }

  Future<SelectionCounts?> commitSelection(String listId) async {
    if (!_canShield) return null;
    try {
      final raw = await _channel.invokeMethod<Object?>('commitSelection', {
        'listId': listId,
      });
      return SelectionCounts.fromChannel(raw);
    } on PlatformException catch (error) {
      throw FocusShieldException(error.code, error.message ?? '');
    }
  }

  /// Selections stored on this device, keyed by list id.
  ///
  /// Null when the device cannot answer, so callers leave saved counts alone.
  /// An empty map means none of [listIds] have apps saved here.
  Future<Map<String, SelectionCounts>?> storedSelections(
    List<String> listIds,
  ) async {
    if (!storesSelections || listIds.isEmpty) return null;
    try {
      final raw = await _channel.invokeMethod<Object?>('storedSelections', {
        'listIds': listIds,
      });
      if (raw is! Map) return const {};
      final stored = <String, SelectionCounts>{};
      for (final entry in raw.entries) {
        final id = entry.key;
        if (id is! String) continue;
        final counts = SelectionCounts.fromChannel(entry.value);
        if (counts != null && counts.total > 0) stored[id] = counts;
      }
      return stored;
    } catch (error, stack) {
      debugPrint('storedSelections failed: $error\n$stack');
      return null;
    }
  }

  /// Names of the apps stored for each list id. Missing lists are omitted.
  Future<Map<String, List<String>>> applicationNames(
    List<String> listIds,
  ) async {
    if (!_canShield || listIds.isEmpty) return const {};
    try {
      final raw = await _channel.invokeMethod<Object?>('applicationNames', {
        'listIds': listIds,
      });
      if (raw is! Map) return const {};
      final names = <String, List<String>>{};
      for (final entry in raw.entries) {
        final id = entry.key;
        if (id is! String) continue;
        final parsed = _stringList(entry.value);
        if (parsed.isNotEmpty) names[id] = parsed;
      }
      return names;
    } catch (error, stack) {
      debugPrint('applicationNames failed: $error\n$stack');
      return const {};
    }
  }

  Future<void> discardDraft(String listId) async {
    if (!_canShield) return;
    try {
      await _channel.invokeMethod<void>('discardDraft', {'listId': listId});
    } catch (error, stack) {
      debugPrint('discardDraft failed: $error\n$stack');
    }
  }

  Future<void> deleteSelection(String listId) async {
    if (!_canShield) return;
    try {
      await _channel.invokeMethod<void>('deleteSelection', {'listId': listId});
    } catch (error, stack) {
      debugPrint('deleteSelection failed: $error\n$stack');
    }
  }

  /// Applies the shield for [listId].
  ///
  /// A null [endsAt] leaves the shield on until the session is ended. When
  /// [strict] is true, a scheduling failure removes the shield and throws.
  /// Repair calls use strict false so an already-running session keeps its shield.
  Future<void> startSession({
    required String listId,
    DateTime? endsAt,
    bool strict = true,
  }) async {
    if (!_canShield) {
      if (strict) {
        throw const FocusShieldException('UNAVAILABLE', '');
      }
      return;
    }
    try {
      await _channel.invokeMethod<void>('startSession', {
        'listId': listId,
        if (endsAt != null) 'endsAtMillis': endsAt.millisecondsSinceEpoch,
        'strict': strict,
      });
    } on PlatformException catch (error) {
      throw FocusShieldException(error.code, error.message ?? '');
    }
  }

  Future<void> stopSession() async {
    if (!_canShield) return;
    try {
      await _channel.invokeMethod<void>('stopSession');
    } catch (error, stack) {
      debugPrint('stopSession failed: $error\n$stack');
    }
  }
}
