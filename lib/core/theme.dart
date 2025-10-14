import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5), // SnapCart primary
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF9FAFB),
    useMaterial3: true,
    fontFamily: 'Roboto',
  );
}