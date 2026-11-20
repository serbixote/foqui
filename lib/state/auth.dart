import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = NotifierProvider<AuthNotifier, Auth>(AuthNotifier.new);

enum LoginState { unknown, loggedIn, loggedOut }

@immutable
class Auth {
  const Auth({this.loginState = LoginState.unknown, this.userId});

  final LoginState loginState;
  final String? userId;

  bool get isLoggedIn => loginState == LoginState.loggedIn && userId != null;

  bool get isLoggedOut => loginState == LoginState.loggedOut;
}

class AuthNotifier extends Notifier<Auth> {
  @override
  Auth build() {
    final subscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) {
      if (user == null) {
        state = const Auth(loginState: LoginState.loggedOut);
        return;
      }
      state = Auth(loginState: LoginState.loggedIn, userId: user.uid);
    });
    ref.onDispose(subscription.cancel);
    return const Auth(loginState: LoginState.unknown);
  }

  Future<User?> signInWithGoogle() async {
    try {
      await initializeGoogleSignIn();
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'missing-id-token',
          message: 'Google sign-in did not return an ID token.',
        );
      }
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final user = (await FirebaseAuth.instance.signInWithCredential(
        credential,
      )).user;
      await user?.getIdToken(true);
      return user;
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final provider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');
      final user = (await FirebaseAuth.instance.signInWithProvider(provider))
          .user;
      await user?.getIdToken(true);
      return user;
    } on FirebaseAuthException catch (error) {
      if (_isCancel(error)) return null;
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (error, stack) {
      debugPrint('Google sign-out failed: $error\n$stack');
    }
  }
}

var _googleSignInReady = false;

Future<void> initializeGoogleSignIn() async {
  if (_googleSignInReady) return;
  await GoogleSignIn.instance.initialize();
  _googleSignInReady = true;
}

bool _isCancel(FirebaseAuthException error) {
  return error.code == 'canceled' ||
      error.code == 'web-context-canceled' ||
      error.code == 'web-context-cancelled';
}
