import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

const _warmCanvas = BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0, -1.05),
    radius: 1.35,
    colors: [FoquiWelcome.sun, FoquiWelcome.lilac, FoquiWelcome.paper],
    stops: [0, 0.34, 0.72],
  ),
);

const _lilacCanvas = BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0, -1.05),
    radius: 1.35,
    colors: [FoquiWelcome.lilac, FoquiWelcome.paper],
    stops: [0, 0.72],
  ),
);

/// Dim lilac canvas for sign-in and onboarding.
///
/// [warm] adds the gold spot near the top. Sign-in leaves it off.
class WelcomeFrame extends StatelessWidget {
  const WelcomeFrame({super.key, required this.child, this.warm = true});

  final Widget child;
  final bool warm;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: FoquiWelcome.paper,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Theme(
        data: AppTheme.welcome,
        child: Scaffold(
          backgroundColor: FoquiWelcome.paper,
          resizeToAvoidBottomInset: false,
          body: DecoratedBox(
            decoration: warm ? _warmCanvas : _lilacCanvas,
            child: child,
          ),
        ),
      ),
    );
  }
}
