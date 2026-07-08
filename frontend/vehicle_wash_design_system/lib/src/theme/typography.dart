import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterpriseTypography {
  // Display - DM Sans
  static TextStyle displayLarge([Color? color]) => GoogleFonts.dmSans(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        height: 1.04,
        letterSpacing: -1.0,
        color: color,
      );

  static TextStyle displayMedium([Color? color]) => GoogleFonts.dmSans(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.5,
        color: color,
      );

  static TextStyle displaySmall([Color? color]) => GoogleFonts.dmSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.25,
        color: color,
      );

  // Headlines - DM Sans
  static TextStyle headlineLarge([Color? color]) => GoogleFonts.dmSans(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.25,
        color: color,
      );

  static TextStyle headlineMedium([Color? color]) => GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0,
        color: color,
      );

  // Title - DM Sans
  static TextStyle titleLarge([Color? color]) => GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0,
        color: color,
      );

  static TextStyle titleMedium([Color? color]) => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.15,
        color: color,
      );

  // Body - DM Sans
  static TextStyle bodyLarge([Color? color]) => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.5,
        color: color,
      );

  static TextStyle bodyMedium([Color? color]) => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.25,
        color: color,
      );

  // Label - DM Sans
  static TextStyle labelLarge([Color? color]) => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.25,
        color: color,
      );

  static TextStyle labelMedium([Color? color]) => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.5,
        color: color,
      );
      
  static TextStyle labelSmall([Color? color]) => GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.5,
        color: color,
      );
}
