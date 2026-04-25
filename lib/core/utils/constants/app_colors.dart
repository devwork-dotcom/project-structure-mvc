import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF1F6B6A);
  static const Color secondary = Color(0x522DD4BF);
  static const Color backgroundColor = Color(0xFFDCE8DF);
  static const Color textPrimary = Color(0xFF1F5F5E);
  static const Color textSecondary = Color(0xFF6F7F7C);
  static const Color hintColor = Color(0xFF9BB3AE);
  static const Color borderColor = Color(0xFFB7CBC5);
  static const Color containerColor = Color(0xFFFFFFFF);
  static const Color containerSoft = Color(0xFFF4F8F6);
  static const Color containerBorder = Color(0xFFE0ECE8);
  static const Color shadowColor = Color(0x14000000);

  // boxShadow: [
  // BoxShadow(
  // color: Color(0x14000000), // very light shadow
  // blurRadius: 12,
  // offset: Offset(0, 4),
  // ),
  // ]

  // Gradient Colors
  static const Gradient verseGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF3E8F88), Color(0xFF2F6E69)],
  );
  static const Gradient mindsetAlignGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
  );

  // Utility Colors
  static const Color success = Color(0xFF16A34A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFDD3333);
  static const Color info = Color(0xFF29B6F6);

  static String toWebHex(Color color) {
    final value = color.toARGB32() & 0xFFFFFF;
    return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
