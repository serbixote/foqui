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

  Future<void> claimProfile({required String alias, required String username});

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
  Future<void> claimProfile({required String alias, required String username}) {
    final cleanedAlias = alias.trim();
    final normalized = Username.normalize(username);
    if (!Username.isAliasValid(cleanedAlias) || !Username.isValid(normalized)) {
      throw ArgumentError('Invalid profile');
    }

    return _guard(() async {
      final usernameRef = firestore
          .collection(usernamesCollection)
          .doc(normalized);
      // Returning normally keeps the transaction from retrying. A thrown
      // error inside the handler is retried, which would multiply reads.
      var taken = false;
      await firestore.runTransaction((transaction) async {
        taken = false;
        final usernameSnap = await transaction.get(usernameRef);
        final owner = usernameSnap.data()?[usernameOwnerField];
        if (usernameSnap.exists && owner != userId) {
          taken = true;
          return;
        }

        final userSnap = await transaction.get(_user);
        final previous = userSnap.data()?[usernameField];
        if (previous is String &&
            previous.isNotEmpty &&
            previous != normalized) {
          transaction.delete(
            firestore.collection(usernamesCollection).doc(previous),
          );
        }

        transaction.set(usernameRef, {
          usernameOwnerField: userId,
          aliasField: cleanedAlias,
        });
        final createdAt = userSnap.data()?[createdAtField];
        transaction.set(_user, {
          aliasField: cleanedAlias,
          usernameField: normalized,
          if (createdAt == null)
            createdAtField: DateTime.now().millisecondsSinceEpoch,
        }, SetOptions(merge: true));
      });
      if (taken) throw const UsernameTaken();
    });
  }

  @override
  Future<void> completeOnboarding() {
    return _guard(() async {
      await _user.set({onboardedField: true}, SetOptions(merge: true));
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
