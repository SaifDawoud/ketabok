import 'package:flutter/material.dart';

class MyTheme {
  static const Color orangColor = Color(0xFFF9B091);
  static const Color darkScaffold = Color(0xFF040C23);
  static const Color primaryColor = Color(0xFFA44AFF);
  static const Color lightScaffold = Color(0xFFFFFFFF);
  static const Color text = Color(0xFFA19CC5);

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkScaffold,
    useMaterial3: true,
  );
}
