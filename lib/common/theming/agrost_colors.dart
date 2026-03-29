import 'package:flutter/material.dart';

abstract final class AgrostColors {
  // ── Primary Accent (Lime Green) ──────────────────────────────────
  static const Color primary = Color(0xFFDBFB9A);
  static const Color primaryBright = Color(0xFFAEF416);
  static const Color primaryDark = Color(0xFF8BC34A);
  static const Color primaryMuted = Color(0xFFE8FCBE);

  // ── Neutral / Text ───────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF191B1D);
  static const Color textSecondary = Color(0xFF6F7679);
  static const Color textTertiary = Color(0xFF929B9D);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFF191B1D);

  // ── Surface ──────────────────────────────────────────────────────
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF4F6F8);
  static const Color surfaceDark = Color(0xFF121416);
  static const Color surfaceContainerDark = Color(0xFF1E2022);

  // ── Border / Divider ─────────────────────────────────────────────
  static const Color border = Color(0xFFE6EAED);
  static const Color borderDark = Color(0xFF2C3033);
  static const Color divider = Color(0xFFE6EAED);
  static const Color dividerDark = Color(0xFF2C3033);

  // ── Error ────────────────────────────────────────────────────────
  static const Color error = Color(0xFFFF685F);
  static const Color errorLight = Color(0xFFFFDAD6);
  static const Color errorDark = Color(0xFFCF4038);

  // ── Semantic ─────────────────────────────────────────────────────
  static const Color success = Color(0xFFAEF416);
  static const Color successContainer = Color(0xFFE8FCBE);
  static const Color warning = Color(0xFFFCF1CD);
  static const Color warningDark = Color(0xFF7E3219);
  static const Color info = Color(0xFF5B9BD5);
  static const Color infoContainer = Color(0xFFD6E8F5);

  // ── Placeholder / Disabled ───────────────────────────────────────
  static const Color placeholder = Color(0xFFD9D9D9);
  static const Color disabled = Color(0xFFE6EAED);
  static const Color disabledText = Color(0xFF929B9D);

  // ── Neutrals (full scale) ────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF191B1D);
  static const Color grey50 = Color(0xFFF4F6F8);
  static const Color grey100 = Color(0xFFE6EAED);
  static const Color grey200 = Color(0xFFD9D9D9);
  static const Color grey300 = Color(0xFF929B9D);
  static const Color grey400 = Color(0xFF6F7679);
  static const Color grey500 = Color(0xFF4A4F52);
  static const Color grey600 = Color(0xFF2C3033);
  static const Color grey700 = Color(0xFF1E2022);
  static const Color grey800 = Color(0xFF191B1D);
}
