import 'package:flutter/material.dart';

class AppTheme {
  static const Color green = Color(0xFF27AE60);
  static const Color red = Color(0xFFE74C3C);
  static const Color blue = Color(0xFF2980B9);
  static const Color dark = Color(0xFF2C3E50);
  static const Color purple = Color(0xFF8E44AD);
  static const Color bg = Color(0xFFF5F6FA);

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: dark),
    useMaterial3: true,
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: dark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
