import 'package:flutter/material.dart';

class MyTheme {
  static const Color orangColor = Color(0xFFF9B091);
  static const Color darkScaffold = Color(0xFF040C23);
  static const Color primaryColor = Color(0xFFA44AFF);
  static const Color lightScaffold = Color(0xFFFFFFFF);
  static const Color text = Color(0xFFA19CC5);
  static const Color bottomNavBarBG = Color(0xFF121931);
  static const Color startgradient = Color(0xFFDF98FA);
  static const Color middlegradient = Color(0xFFB776FD);
  static const Color endgradient = Color(0xFF9055FF);

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkScaffold,
    useMaterial3: true,
  );
}
