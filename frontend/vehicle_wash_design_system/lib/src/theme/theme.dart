import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';

class EnterpriseTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: EnterpriseColors.backgroundLight,
      primaryColor: EnterpriseColors.primary,
      colorScheme: const ColorScheme.light(
        primary: EnterpriseColors.primary,
        secondary: EnterpriseColors.secondary,
        surface: EnterpriseColors.surfaceLight,
        error: EnterpriseColors.error,
        onPrimary: EnterpriseColors.textInverseLight,
        onSecondary: EnterpriseColors.textInverseLight,
        onSurface: EnterpriseColors.textPrimaryLight,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: EnterpriseTypography.displayLarge(EnterpriseColors.textPrimaryLight),
        displayMedium: EnterpriseTypography.displayMedium(EnterpriseColors.textPrimaryLight),
        displaySmall: EnterpriseTypography.displaySmall(EnterpriseColors.textPrimaryLight),
        headlineLarge: EnterpriseTypography.headlineLarge(EnterpriseColors.textPrimaryLight),
        headlineMedium: EnterpriseTypography.headlineMedium(EnterpriseColors.textPrimaryLight),
        titleLarge: EnterpriseTypography.titleLarge(EnterpriseColors.textPrimaryLight),
        titleMedium: EnterpriseTypography.titleMedium(EnterpriseColors.textPrimaryLight),
        bodyLarge: EnterpriseTypography.bodyLarge(EnterpriseColors.textPrimaryLight),
        bodyMedium: EnterpriseTypography.bodyMedium(EnterpriseColors.textSecondaryLight),
        labelLarge: EnterpriseTypography.labelLarge(EnterpriseColors.textPrimaryLight),
        labelMedium: EnterpriseTypography.labelMedium(EnterpriseColors.textSecondaryLight),
        labelSmall: EnterpriseTypography.labelSmall(EnterpriseColors.textSecondaryLight),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: EnterpriseTypography.headlineMedium(EnterpriseColors.textPrimaryLight),
        iconTheme: const IconThemeData(color: EnterpriseColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData(
        color: EnterpriseColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: EnterpriseRadius.innerRadius,
          side: const BorderSide(color: EnterpriseColors.borderLight, width: 1),
        ),
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: EnterpriseColors.borderLight,
        thickness: 1,
        space: EnterpriseSpacing.gap,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: EnterpriseColors.backgroundDark,
      primaryColor: EnterpriseColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: EnterpriseColors.primary,
        secondary: EnterpriseColors.secondary,
        surface: EnterpriseColors.surfaceDark,
        error: EnterpriseColors.error,
        onPrimary: EnterpriseColors.textInverseDark,
        onSecondary: EnterpriseColors.textInverseDark,
        onSurface: EnterpriseColors.textPrimaryDark,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: EnterpriseTypography.displayLarge(EnterpriseColors.textPrimaryDark),
        displayMedium: EnterpriseTypography.displayMedium(EnterpriseColors.textPrimaryDark),
        displaySmall: EnterpriseTypography.displaySmall(EnterpriseColors.textPrimaryDark),
        headlineLarge: EnterpriseTypography.headlineLarge(EnterpriseColors.textPrimaryDark),
        headlineMedium: EnterpriseTypography.headlineMedium(EnterpriseColors.textPrimaryDark),
        titleLarge: EnterpriseTypography.titleLarge(EnterpriseColors.textPrimaryDark),
        titleMedium: EnterpriseTypography.titleMedium(EnterpriseColors.textPrimaryDark),
        bodyLarge: EnterpriseTypography.bodyLarge(EnterpriseColors.textPrimaryDark),
        bodyMedium: EnterpriseTypography.bodyMedium(EnterpriseColors.textSecondaryDark),
        labelLarge: EnterpriseTypography.labelLarge(EnterpriseColors.textPrimaryDark),
        labelMedium: EnterpriseTypography.labelMedium(EnterpriseColors.textSecondaryDark),
        labelSmall: EnterpriseTypography.labelSmall(EnterpriseColors.textSecondaryDark),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: EnterpriseTypography.headlineMedium(EnterpriseColors.textPrimaryDark),
        iconTheme: const IconThemeData(color: EnterpriseColors.textPrimaryDark),
      ),
      cardTheme: CardThemeData(
        color: EnterpriseColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: EnterpriseRadius.innerRadius,
          side: const BorderSide(color: EnterpriseColors.borderDark, width: 1),
        ),
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: EnterpriseColors.borderDark,
        thickness: 1,
        space: EnterpriseSpacing.gap,
      ),
    );
  }
}
