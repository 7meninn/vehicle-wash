import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class VerdantTypography {
  // Display - Playfair Display
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
        fontSize: 64,
        fontWeight: FontWeight.w500,
        height: 1.04,
        letterSpacing: 0,
        color: VerdantColors.textPrimary,
      );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
        fontSize: 48,
        fontWeight: FontWeight.w500,
        height: 1.1,
        letterSpacing: 0,
        color: VerdantColors.textPrimary,
      );

  static TextStyle get displaySmall => GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        height: 1.15,
        letterSpacing: 0,
        color: VerdantColors.textPrimary,
      );

  // Headlines - Playfair Display
  static TextStyle get headlineLarge => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0,
        color: VerdantColors.textPrimary,
      );

  static TextStyle get headlineMedium => GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0,
        color: VerdantColors.textPrimary,
      );

  // Title - Inter
  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500, // Medium
        height: 1.3,
        color: VerdantColors.textPrimary,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500, // Medium
        height: 1.5,
        letterSpacing: 0.15,
        color: VerdantColors.textPrimary,
      );

  // Body - Inter
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        height: 1.6,
        letterSpacing: 0.5,
        color: VerdantColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        height: 1.6,
        letterSpacing: 0.25,
        color: VerdantColors.textSecondary,
      );

  // Label - JetBrains Mono
  static TextStyle get labelLarge => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.2,
        letterSpacing: 1.25, // Tracking widest
        color: VerdantColors.textPrimary,
      );

  static TextStyle get labelMedium => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.2,
        letterSpacing: 1.5,
        color: VerdantColors.textSecondary,
      );
      
  static TextStyle get labelSmall => GoogleFonts.jetBrainsMono(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.5,
        color: VerdantColors.textSecondary,
      );
}
