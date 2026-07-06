import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';

class VerdantTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: VerdantColors.background,
      primaryColor: VerdantColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: VerdantColors.primary,
        secondary: VerdantColors.secondary,
        surface: VerdantColors.surface,
        background: VerdantColors.background,
        error: Colors.redAccent,
        onPrimary: VerdantColors.textInverse,
        onSecondary: VerdantColors.textInverse,
        onSurface: VerdantColors.textPrimary,
        onBackground: VerdantColors.textPrimary,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: VerdantTypography.displayLarge,
        displayMedium: VerdantTypography.displayMedium,
        displaySmall: VerdantTypography.displaySmall,
        headlineLarge: VerdantTypography.headlineLarge,
        headlineMedium: VerdantTypography.headlineMedium,
        titleLarge: VerdantTypography.titleLarge,
        titleMedium: VerdantTypography.titleMedium,
        bodyLarge: VerdantTypography.bodyLarge,
        bodyMedium: VerdantTypography.bodyMedium,
        labelLarge: VerdantTypography.labelLarge,
        labelMedium: VerdantTypography.labelMedium,
        labelSmall: VerdantTypography.labelSmall,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: VerdantTypography.headlineMedium,
        iconTheme: const IconThemeData(color: VerdantColors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: VerdantColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: VerdantRadius.innerRadius,
          side: const BorderSide(color: VerdantColors.border, width: 1),
        ),
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: VerdantColors.border,
        thickness: 1,
        space: VerdantSpacing.gap,
      ),
    );
  }
}
