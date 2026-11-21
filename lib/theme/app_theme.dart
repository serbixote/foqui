import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Always-dark translation of Billy and Tidify, with Foqui's purple accent.
///
/// The canvas is charcoal, not pure black. Cards and sheets sit one step
/// lighter so they still separate from the screen. The highlight is the
/// previous violet: strong enough to mark the main actions, short of the
/// bright glow. Sign-in and onboarding are the exception: they use [FoquiWelcome].
abstract final class FoquiColors {
  static const violet = Color(0xFF8154E8);
  static const destructive = Color(0xFFFF453A);
  static const caution = Color(0xFFFF9F0A);
  static const canvas = Color(0xFF1C1C1E);
  static const surface = Color(0xFF2C2C2E);
  static const grouped = Color(0xFF3A3A3C);
  static const raised = Color(0xFF48484A);
  static const separator = Color(0xFF48484A);
  static const secondaryLabel = Color(0xFF8E8E93);
  static const hairline = Color(0x14FFFFFF);
}

/// Dim lilac for sign-in and onboarding. Lighter than the charcoal canvas, and quiet
/// enough that the rest of the app can move toward these colors.
abstract final class FoquiWelcome {
  static const paper = Color(0xFF322C48);
  static const sun = Color(0xFF6E5840);
  static const lilac = Color(0xFF443C62);
  static const stage = Color(0xFF6A5C96);
  static const ink = Color(0xFFF4F0FA);
  static const muted = Color(0xFFB9B0CC);
  static const line = Color(0xFF564E70);
  static const track = Color(0xFF7A7196);
  static const field = Color(0xFF4A4364);
}

abstract final class AppTheme {
  static final ThemeData dark = _build();
  static final ThemeData welcome = _welcome();

  static const _buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  static ThemeData _welcome() {
    const primary = FoquiColors.violet;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
          surface: FoquiWelcome.paper,
          dynamicSchemeVariant: DynamicSchemeVariant.neutral,
        ).copyWith(
          primary: primary,
          onPrimary: Colors.white,
          secondary: primary,
          onSecondary: Colors.white,
          error: FoquiColors.destructive,
          onError: Colors.white,
          surface: FoquiWelcome.paper,
          onSurface: FoquiWelcome.ink,
          onSurfaceVariant: FoquiWelcome.muted,
          outline: FoquiWelcome.line,
          outlineVariant: FoquiWelcome.line,
          surfaceTint: Colors.transparent,
          surfaceContainerHighest: FoquiWelcome.field,
          surfaceContainerHigh: FoquiWelcome.field,
          surfaceContainer: FoquiWelcome.field,
          surfaceContainerLow: FoquiWelcome.paper,
          surfaceContainerLowest: FoquiWelcome.paper,
        );

    final textTheme = ThemeData(brightness: Brightness.dark, useMaterial3: true)
        .textTheme
        .apply(bodyColor: FoquiWelcome.ink, displayColor: FoquiWelcome.ink);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: FoquiWelcome.paper,
      splashFactory: InkRipple.splashFactory,
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: FoquiWelcome.ink),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: primary,
        applyThemeToAll: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primary,
          disabledForegroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
          textStyle: _buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: _buttonText,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primary,
        selectionHandleColor: primary,
        selectionColor: Color(0x338154E8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: FoquiWelcome.field,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: FoquiWelcome.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: FoquiWelcome.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
    );
  }

  static ThemeData _build() {
    const primary = FoquiColors.violet;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
          surface: FoquiColors.surface,
          dynamicSchemeVariant: DynamicSchemeVariant.neutral,
        ).copyWith(
          primary: primary,
          onPrimary: Colors.white,
          secondary: primary,
          onSecondary: Colors.white,
          error: FoquiColors.destructive,
          onError: Colors.white,
          surface: FoquiColors.surface,
          onSurface: Colors.white,
          onSurfaceVariant: FoquiColors.secondaryLabel,
          outline: FoquiColors.raised,
          outlineVariant: FoquiColors.separator,
          surfaceTint: Colors.transparent,
          surfaceContainerHighest: FoquiColors.grouped,
          surfaceContainerHigh: FoquiColors.grouped,
          surfaceContainer: FoquiColors.surface,
          surfaceContainerLow: FoquiColors.surface,
          surfaceContainerLowest: FoquiColors.canvas,
        );

    final textTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: FoquiColors.canvas,
      splashFactory: InkRipple.splashFactory,
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: primary,
        applyThemeToAll: true,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primary,
          disabledForegroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
          textStyle: _buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: _buttonText,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return FoquiColors.raised;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: FoquiColors.surface,
        modalBackgroundColor: FoquiColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 0.5,
        space: 0.5,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
