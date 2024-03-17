import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgrostTheming {
  static ThemeData get lightTheme {
    return _themeBase(Colors.green);
  }

  static ThemeData get darkTheme {
    return _themeBase(Colors.green);
  }

  static ThemeData _themeBase(Color color) {
    return ThemeData(
      colorSchemeSeed: color,
      textTheme: textTheme,
      iconTheme: const IconThemeData(size: 24),
      appBarTheme: const AppBarTheme(centerTitle: false),
      navigationBarTheme: const NavigationBarThemeData(labelBehavior: NavigationDestinationLabelBehavior.alwaysHide),
      tabBarTheme: const TabBarTheme(indicatorSize: TabBarIndicatorSize.tab),
      switchTheme: const SwitchThemeData(splashRadius: 1),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  static TextStyle get _inter => GoogleFonts.inter();

  static TextTheme get textTheme => TextTheme(
        ///H
        displayLarge: _inter.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        displayMedium: _inter.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        displaySmall: _inter.copyWith(fontSize: 16, fontWeight: FontWeight.bold),

        ///Titles
        titleLarge: _inter.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        titleMedium: _inter.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: _inter.copyWith(fontSize: 12, fontWeight: FontWeight.w400),

        ///Body
        bodyMedium: _inter.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
        bodySmall: _inter.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
      );
}
