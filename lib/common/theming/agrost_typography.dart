import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AgrostTypography {
  static TextStyle get _baseInter => GoogleFonts.inter();

  // ── Display ──────────────────────────────────────────────────────
  static TextStyle get displayLarge => _baseInter.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.5,
      );

  static TextStyle get displayMedium => _baseInter.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.33,
        letterSpacing: -0.25,
      );

  static TextStyle get displaySmall => _baseInter.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  // ── Headline ─────────────────────────────────────────────────────
  static TextStyle get headlineLarge => _baseInter.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
      );

  static TextStyle get headlineMedium => _baseInter.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.36,
      );

  static TextStyle get headlineSmall => _baseInter.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  // ── Title ────────────────────────────────────────────────────────
  static TextStyle get titleLarge => _baseInter.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  static TextStyle get titleMedium => _baseInter.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle get titleSmall => _baseInter.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      );

  // ── Body ─────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => _baseInter.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle get bodyMedium => _baseInter.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => _baseInter.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      );

  // ── Label ────────────────────────────────────────────────────────
  static TextStyle get labelLarge => _baseInter.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => _baseInter.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => _baseInter.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
