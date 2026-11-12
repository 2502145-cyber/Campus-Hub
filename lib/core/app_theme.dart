import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 175, 221, 133),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 234, 236, 122),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Color.fromARGB(255, 255, 176, 145),
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
