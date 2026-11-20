import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/models/user_profile.dart';
import 'package:foqui/models/username.dart';
import 'package:foqui/state/profile.dart';

void main() {
  test('usernames are lowercase handles of 3 to 20 characters', () {
    expect(Username.normalize('  Marco '), 'marco');
    expect(Username.isValid('abc'), isTrue);
    expect(Username.isValid('a_b'), isTrue);
    expect(Username.isValid('marco_1'), isTrue);
    expect(Username.isValid('a' * 20), isTrue);

    expect(Username.isValid('ab'), isFalse);
    expect(Username.isValid('a' * 21), isFalse);
    expect(Username.isValid('1abc'), isFalse);
    expect(Username.isValid('_abc'), isFalse);
    expect(Username.isValid('hello-world'), isFalse);
    expect(Username.isValid(''), isFalse);
  });

  test('reserved usernames are rejected before a lookup', () {
    expect(Username.isReserved('foqui'), isTrue);
    expect(Username.isReserved('admin'), isTrue);
    expect(Username.isValid('foqui'), isFalse);
    expect(Username.isValid('support'), isFalse);
    expect(Username.isReserved('marco'), isFalse);
  });

  test('an alias is a trimmed name up to 40 characters', () {
    expect(Username.isAliasValid('  Ada '), isTrue);
    expect(Username.isAliasValid('A' * 40), isTrue);
    expect(Username.isAliasValid(''), isFalse);
    expect(Username.isAliasValid('   '), isFalse);
    expect(Username.isAliasValid('A' * 41), isFalse);
  });

  test('a profile without onboarded still needs onboarding', () {
    expect(
      destinationFor(const AsyncData(UserProfile(username: 'ada'))),
      SignedInDestination.onboarding,
    );
    expect(
      destinationFor(
        const AsyncData(UserProfile(username: 'ada', onboarded: true)),
      ),
      SignedInDestination.ready,
    );
    expect(
      destinationFor(const AsyncLoading<UserProfile>()),
      SignedInDestination.loading,
    );
    expect(
      destinationFor(AsyncError<UserProfile>('down', StackTrace.empty)),
      SignedInDestination.unavailable,
    );
  });
}
