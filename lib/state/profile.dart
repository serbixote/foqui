import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../repositories/user.dart';

final userProfileProvider = StreamProvider<UserProfile>((ref) {
  final directory = ref.watch(userRepositoryProvider);
  if (directory == null) return const Stream<UserProfile>.empty();
  return directory.watchProfile();
});

enum SignedInDestination { loading, onboarding, ready, unavailable }

/// Where a signed-in person should land. Missing `onboarded` means the
/// profile was created before onboarding existed, so they still go through it.
SignedInDestination destinationFor(AsyncValue<UserProfile> profile) {
  return profile.when(
    loading: () => SignedInDestination.loading,
    error: (Object _, StackTrace _) => SignedInDestination.unavailable,
    data: (profile) => profile.onboarded
        ? SignedInDestination.ready
        : SignedInDestination.onboarding,
  );
}
