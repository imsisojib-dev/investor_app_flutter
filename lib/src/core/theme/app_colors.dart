import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF008647);
  static const Color secondary = Color(0xFF0DA183);
  static const Color primarySecondary = Color(0xFF128E54);

  // Light theme colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFBF5);
  static const Color lightTextPrimary = Color(0xFF3D3D3D);
  static const Color lightTextSecondary = Color(0xFF67748D);
  static const Color lightDivider = Color(0xFFCFD6E2);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkDivider = Color(0xFF2C2C2C);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);

  // Basic colors
  static const Color white = Color(0xFFFFFFFF);
}

// Extend ColorScheme with custom colors
extension AppColorScheme on ColorScheme {
  Color get textSecondary => brightness == Brightness.light
      ? const Color(0xFF666666)
      : const Color(0xFFB0B0B0);

  Color get textTertiary => brightness == Brightness.light
      ? const Color(0xFF999999)
      : const Color(0xFF808080);

  Color get cardColor => brightness == Brightness.light
      ? const Color(0xFFFFFBF5)
      : const Color(0xFF1E1E1E);

  Color get dividerColor => brightness == Brightness.light
      ? const Color(0xFFE0E0E0)
      : const Color(0xFF2C2C2C);

  Color get hintColor => brightness == Brightness.light
      ? const Color(0xFF999999)
      : const Color(0xFF666666);

  Color get iconSecondary => brightness == Brightness.light
      ? const Color(0xFF666666)
      : const Color(0xFFB0B0B0);

  Color get success => const Color(0xFF4CAF50);
  Color get warning => const Color(0xFFFFA726);
  Color get info => const Color(0xFF29B6F6);
}