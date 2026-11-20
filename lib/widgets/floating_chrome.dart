import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Capsule or circle chrome that stays readable when it overlaps content.
///
/// A hairline keeps the bar visible on the charcoal canvas. The solid action
/// button gets a soft tinted shadow instead, the way Billy's add button sits
/// off the tab bar.
class FloatingChrome extends StatelessWidget {
  const FloatingChrome({
    super.key,
    required this.isDark,
    required this.shape,
    required this.color,
    required this.child,
    this.shadowAlpha = 0.1,
    this.hairline = false,
  });

  final bool isDark;
  final OutlinedBorder shape;
  final Color color;
  final double shadowAlpha;
  final bool hairline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final edge = hairline && isDark
        ? shape.copyWith(side: const BorderSide(color: FoquiColors.hairline))
        : shape;

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: edge,
        shadows: [
          if (hairline)
            const BoxShadow(
              color: Color(0x73000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            )
          else
            BoxShadow(
              color: color.withValues(alpha: shadowAlpha),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Material(
        elevation: 0,
        shape: edge,
        color: color,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
