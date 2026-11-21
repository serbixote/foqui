import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../models/username.dart';
import '../state/auth.dart';
import 'repository.dart';

final userRepositoryProvider = Provider<UserDirectory?>((ref) {
  final auth = ref.watch(authProvider);
  if (!auth.isLoggedIn) return null;
  return UserRepository(auth.userId!);
});

const createdAtField = 'createdAt';

/// Account profile and the global username directory.
abstract class UserDirectory {
  Stream<UserProfile> watchProfile();

  /// One document read. The username is the document id, so this stays a
  /// single read as the directory grows. Callers should debounce.
  Future<bool> isUsernameAvailable(String normalized);

  /// Saves the alias and username on the account and drops any directory
  /// document this account holds. The name stays available until
  /// [completeOnboarding].
  Future<void> saveProfile({required String alias, required String username});

  /// Drops this account's username document when onboarding is unfinished.
  Future<void> releaseUsername();

  /// Publishes the saved username and marks onboarding finished.
  Future<void> completeOnboarding();

  Future<void> createIfDoesNotExist();
}

class UserRepository extends Repository implements UserDirectory {
  UserRepository(this.userId);

  final String userId;

  DocumentReference<Map<String, dynamic>> get _user =>
      firestore.collection(usersCollection).doc(userId);

  @override
  Stream<UserProfile> watchProfile() {
    return _user
        .snapshots()
        .where((snapshot) {
          if (snapshot.exists) return true;
          // An empty cache snapshot would flash onboarding for someone who
          // already finished it. Wait for the server when nothing is cached.
          return !snapshot.metadata.isFromCache;
        })
        .map((snapshot) => UserProfile.fromMap(snapshot.data()));
  }

  @override
  Future<bool> isUsernameAvailable(String normalized) {
    return _guard(() async {
      final snapshot = await firestore
          .collection(usernamesCollection)
          .doc(normalized)
          .get(const GetOptions(source: Source.server));
      if (!snapshot.exists) return true;
      return snapshot.data()?[usernameOwnerField] == userId;
    });
  }

  @override
  Future<void> saveProfile({required String alias, required String username}) {
    final cleanedAlias = alias.trim();
    final normalized = Username.normalize(username);
    if (!Username.isAliasValid(cleanedAlias) || !Username.isValid(normalized)) {
      throw ArgumentError('Invalid profile');
    }

    return _guard(() async {
      await firestore.runTransaction((transaction) async {
        final userSnap = await transaction.get(_user);
        if (userSnap.data()?[onboardedField] == true) return;

        final previous = userSnap.data()?[usernameField];
        final names = <String>{normalized};
        if (previous is String && previous.isNotEmpty) names.add(previous);

        final held = <DocumentReference<Map<String, dynamic>>>[];
        for (final name in names) {
          final ref = firestore.collection(usernamesCollection).doc(name);
          final snap = await transaction.get(ref);
          if (snap.exists && snap.data()?[usernameOwnerField] == userId) {
            held.add(ref);
          }
        }
        for (final ref in held) {
          transaction.delete(ref);
        }

        final createdAt = userSnap.data()?[createdAtField];
        transaction.set(_user, {
          aliasField: cleanedAlias,
          usernameField: normalized,
          if (createdAt == null)
            createdAtField: DateTime.now().millisecondsSinceEpoch,
        }, SetOptions(merge: true));
      });
    });
  }

  @override
  Future<void> releaseUsername() {
    return _guard(() async {
      await firestore.runTransaction((transaction) async {
        final userSnap = await transaction.get(_user);
        final data = userSnap.data();
        if (data?[onboardedField] == true) return;
        final username = data?[usernameField];
        if (username is! String || username.isEmpty) return;

        final ref = firestore.collection(usernamesCollection).doc(username);
        final snap = await transaction.get(ref);
        if (snap.exists && snap.data()?[usernameOwnerField] == userId) {
          transaction.delete(ref);
        }
      });
    });
  }

  @override
  Future<void> completeOnboarding() {
    return _guard(() async {
      // A thrown error inside the handler is retried, which would multiply
      // reads. Flags keep the failure outside the transaction.
      var invalid = false;
      var taken = false;
      await firestore.runTransaction((transaction) async {
        invalid = false;
        taken = false;
        final userSnap = await transaction.get(_user);
        final data = userSnap.data();
        final username = data?[usernameField];
        final alias = data?[aliasField];
        if (username is! String ||
            alias is! String ||
            !Username.isValid(username) ||
            !Username.isAliasValid(alias)) {
          invalid = true;
          return;
        }

        final usernameRef = firestore
            .collection(usernamesCollection)
            .doc(username);
        final usernameSnap = await transaction.get(usernameRef);
        final owner = usernameSnap.data()?[usernameOwnerField];
        if (usernameSnap.exists && owner != userId) {
          taken = true;
          return;
        }

        transaction.set(usernameRef, {
          usernameOwnerField: userId,
          aliasField: alias,
        });
        transaction.set(_user, {onboardedField: true}, SetOptions(merge: true));
      });
      if (invalid) throw ArgumentError('Invalid profile');
      if (taken) throw const UsernameTaken();
    });
  }

  @override
  Future<void> createIfDoesNotExist() async {
    final snapshot = await _user.get();
    if (snapshot.exists) return;
    await _user.set({createdAtField: DateTime.now().millisecondsSinceEpoch});
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on UsernameTaken {
      rethrow;
    } on FirebaseException catch (error, stack) {
      debugPrint('Profile write failed: $error\n$stack');
      final offline =
          error.code == 'unavailable' || error.code == 'network-request-failed';
      throw ProfileWriteException(offline: offline);
    }
  }
}
