import 'dart:convert';

import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';

abstract class FocusRepository {
  const FocusRepository();

  /// False until the first read from storage has arrived.
  bool get hasLoaded => true;

  /// Emits after a later read should replace the in-memory copy.
  Stream<void> get changes => const Stream.empty();

  List<BlockList> readLists();

  Future<void> writeLists(List<BlockList> lists);

  List<FocusSession> readSessions();

  Future<void> writeSessions(List<FocusSession> sessions);

  /// Labels the user added. The built-in labels are not stored here.
  List<FocusLabel> readLabels();

  Future<void> writeLabels(List<FocusLabel> labels);

  void dispose() {}
}

List<BlockList> decodeBlockLists(String? raw) {
  final decoded = _decodeList(raw);
  if (decoded == null) return const [];
  final lists = <BlockList>[];
  for (final item in decoded) {
    if (item is! Map) continue;
    try {
      lists.add(BlockList.fromJson(Map<String, dynamic>.from(item)));
    } catch (_) {
      continue;
    }
  }
  return lists;
}

List<FocusSession> decodeSessions(String? raw) {
  final decoded = _decodeList(raw);
  if (decoded == null) return const [];
  final sessions = <FocusSession>[];
  for (final item in decoded) {
    if (item is! Map) continue;
    try {
      sessions.add(FocusSession.fromJson(Map<String, dynamic>.from(item)));
    } catch (_) {
      continue;
    }
  }
  return sessions;
}

List<dynamic>? _decodeList(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) return decoded;
  } catch (_) {
    return null;
  }
  return null;
}
