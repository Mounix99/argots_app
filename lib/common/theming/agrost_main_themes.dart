import 'package:flutter/material.dart';

import 'agrost_colors.dart';
import 'agrost_spacing.dart';
import 'agrost_theme_extensions.dart';
import 'agrost_typography.dart';

class AgrostTheming {
  AgrostTheming._();

  // ── Light Theme ──────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AgrostColors.primary,
      onPrimary: AgrostColors.textOnPrimary,
      primaryContainer: AgrostColors.primaryMuted,
      onPrimaryContainer: AgrostColors.textPrimary,
      secondary: AgrostColors.textPrimary,
      onSecondary: AgrostColors.primary,
      secondaryContainer: AgrostColors.surfaceContainer,
      onSecondaryContainer: AgrostColors.textPrimary,
      tertiary: AgrostColors.primaryBright,
      onTertiary: AgrostColors.textPrimary,
      tertiaryContainer: AgrostColors.successContainer,
      onTertiaryContainer: AgrostColors.textPrimary,
      error: AgrostColors.error,
      onError: AgrostColors.white,
      errorContainer: AgrostColors.errorLight,
      onErrorContainer: AgrostColors.errorDark,
      surface: AgrostColors.surface,
      onSurface: AgrostColors.textPrimary,
      surfaceContainerHighest: AgrostColors.surfaceContainer,
      onSurfaceVariant: AgrostColors.textSecondary,
      outline: AgrostColors.border,
      outlineVariant: AgrostColors.divider,
    );

    return _buildTheme(colorScheme, Brightness.light);
  }

  // ── Dark Theme ───────────────────────────────────────────────────
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AgrostColors.primary,
      onPrimary: AgrostColors.textPrimary,
      primaryContainer: AgrostColors.primaryDark,
      onPrimaryContainer: AgrostColors.primary,
      secondary: AgrostColors.white,
      onSecondary: AgrostColors.textPrimary,
      secondaryContainer: AgrostColors.grey600,
      onSecondaryContainer: AgrostColors.white,
      tertiary: AgrostColors.primaryBright,
      onTertiary: AgrostColors.textPrimary,
      tertiaryContainer: Color(0xFF3A4A1A),
      onTertiaryContainer: AgrostColors.primary,
      error: AgrostColors.error,
      onError: AgrostColors.white,
      errorContainer: Color(0xFF93000A),
      onErrorContainer: AgrostColors.errorLight,
      surface: AgrostColors.surfaceDark,
      onSurface: AgrostColors.white,
      surfaceContainerHighest: AgrostColors.surfaceContainerDark,
      onSurfaceVariant: AgrostColors.grey300,
      outline: AgrostColors.borderDark,
      outlineVariant: AgrostColors.grey600,
    );

    return _buildTheme(colorScheme, Brightness.dark);
  }

  // ── Shared builder ───────────────────────────────────────────────
  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final textTheme = AgrostTypography.textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      iconTheme: IconThemeData(
        size: 24,
        color: colorScheme.onSurface,
      ),

      // ── AppBar ─────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: AgrostTypography.titleLarge.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // ── Bottom Navigation ──────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: isLight
            ? AgrostColors.textTertiary
            : AgrostColors.grey300,
        elevation: 0,
        selectedLabelStyle: AgrostTypography.labelSmall,
        unselectedLabelStyle: AgrostTypography.labelSmall,
      ),

      // ── Navigation Bar (Material 3) ───────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: colorScheme.surface,
        indicatorColor: AgrostColors.primary,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(
          AgrostTypography.labelSmall.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),

      // ── TabBar ─────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: isLight
            ? AgrostColors.textTertiary
            : AgrostColors.grey300,
        labelStyle: AgrostTypography.labelLarge,
        unselectedLabelStyle: AgrostTypography.labelLarge,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colorScheme.onSurface,
            width: 2,
          ),
        ),
      ),

      // ── Input Decoration ───────────────────────────────────────
      // Figma: white fill, #E6EAED border, rx=12, 55px tall
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? AgrostColors.white : AgrostColors.surfaceContainerDark,
        contentPadding: AgrostSpacing.inputContentPadding,
        border: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(color: AgrostColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(color: isLight ? AgrostColors.border : AgrostColors.borderDark),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(
            color: isLight
                ? AgrostColors.border.withValues(alpha: 0.5)
                : AgrostColors.borderDark.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(color: AgrostColors.textPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(color: AgrostColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
          borderSide: BorderSide(color: AgrostColors.error, width: 1.5),
        ),
        labelStyle: AgrostTypography.bodyMedium.copyWith(
          color: isLight ? AgrostColors.textSecondary : AgrostColors.grey300,
        ),
        hintStyle: AgrostTypography.bodyMedium.copyWith(
          color: isLight ? AgrostColors.textTertiary : AgrostColors.grey300,
        ),
        prefixIconColor: isLight ? AgrostColors.textSecondary : AgrostColors.grey300,
        suffixIconColor: isLight ? AgrostColors.textSecondary : AgrostColors.grey300,
      ),

      // ── Filled Button (Dark background, lime text/icon) ────────
      // Figma: #191B1D fill, rx=27 (pill), 54px tall
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 54),
          backgroundColor: AgrostColors.textPrimary,
          foregroundColor: AgrostColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: AgrostRadii.borderRadiusPill,
          ),
          textStyle: AgrostTypography.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AgrostSpacing.xxl,
            vertical: AgrostSpacing.lg,
          ),
        ),
      ),

      // ── Outlined Button (Lime fill, dark text) ─────────────────
      // Figma: #DBFB9A fill, rx=27 (pill), 54px tall
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 54),
          backgroundColor: AgrostColors.primary,
          foregroundColor: AgrostColors.textPrimary,
          side: BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: AgrostRadii.borderRadiusPill,
          ),
          textStyle: AgrostTypography.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AgrostSpacing.xxl,
            vertical: AgrostSpacing.lg,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: AgrostTypography.labelLarge,
          foregroundColor: colorScheme.onSurface,
        ),
      ),

      // ── Cards ──────────────────────────────────────────────────
      // Figma: #F4F6F8 fill, rx=28 for large / rx=12 for small
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: AgrostRadii.borderRadiusXxl,
        ),
        color: isLight ? AgrostColors.surfaceContainer : AgrostColors.surfaceContainerDark,
        surfaceTintColor: Colors.transparent,
      ),

      // ── ListTile ───────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: AgrostSpacing.listItemPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
        ),
        titleTextStyle: AgrostTypography.titleMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AgrostTypography.bodySmall.copyWith(
          color: isLight ? AgrostColors.textTertiary : AgrostColors.grey300,
        ),
      ),

      // ── Divider ────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: isLight ? AgrostColors.divider : AgrostColors.dividerDark,
        thickness: 1,
        space: 0,
      ),

      // ── Switch ─────────────────────────────────────────────────
      // Figma: #AEF416 active track
      switchTheme: SwitchThemeData(
        splashRadius: 1,
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AgrostColors.primaryBright;
          }
          return isLight ? AgrostColors.border : AgrostColors.borderDark;
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AgrostColors.white;
          }
          return isLight ? AgrostColors.white : AgrostColors.grey300;
        }),
      ),

      // ── SnackBar ───────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: AgrostRadii.borderRadiusMd,
        ),
        backgroundColor: AgrostColors.textPrimary,
        contentTextStyle: AgrostTypography.bodyMedium.copyWith(
          color: AgrostColors.white,
        ),
      ),

      // ── Dialog ─────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: AgrostRadii.borderRadiusXxl,
        ),
        backgroundColor: colorScheme.surface,
        titleTextStyle: AgrostTypography.titleLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: AgrostTypography.bodyMedium.copyWith(
          color: isLight ? AgrostColors.textSecondary : AgrostColors.grey300,
        ),
      ),

      // ── Chip ───────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AgrostRadii.borderRadiusSm,
        ),
        labelStyle: AgrostTypography.labelMedium,
        side: BorderSide(color: isLight ? AgrostColors.border : AgrostColors.borderDark),
      ),

      // ── Extensions ─────────────────────────────────────────────
      extensions: [
        isLight ? AgrostSemanticColors.light : AgrostSemanticColors.dark,
      ],
    );
  }
}
