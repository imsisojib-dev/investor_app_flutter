import 'package:flutter/material.dart';

/*
* Purpose:
* To use custom colors directly from ThemeData
* No need to reference any static class for colors
* Dynamically handled for dark and light theme
*
* Usages:
* final colors = Theme.of(context).appColors;
*/

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color textSecondary;
  final Color textTertiary;
  final Color cardColor;
  final Color dividerColor;
  final Color hintColor;
  final Color iconSecondary;
  final Color success;
  final Color warning;
  final Color info;

  const AppThemeExtension({
    required this.textSecondary,
    required this.textTertiary,
    required this.cardColor,
    required this.dividerColor,
    required this.hintColor,
    required this.iconSecondary,
    required this.success,
    required this.warning,
    required this.info,
  });

  // Light theme colors
  static const light = AppThemeExtension(
    textSecondary: Color(0xFF666666),
    textTertiary: Color(0xFF999999),
    cardColor: Color(0xFFFFFBF5),
    dividerColor: Color(0xFFE0E0E0),
    hintColor: Color(0xFF999999),
    iconSecondary: Color(0xFF666666),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFA726),
    info: Color(0xFF29B6F6),
  );

  // Dark theme colors
  static const dark = AppThemeExtension(
    textSecondary: Color(0xFFB0B0B0),
    textTertiary: Color(0xFF808080),
    cardColor: Color(0xFF1E1E1E),
    dividerColor: Color(0xFF2C2C2C),
    hintColor: Color(0xFF666666),
    iconSecondary: Color(0xFFB0B0B0),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFA726),
    info: Color(0xFF29B6F6),
  );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? textSecondary,
    Color? textTertiary,
    Color? cardColor,
    Color? dividerColor,
    Color? hintColor,
    Color? iconSecondary,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppThemeExtension(
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      cardColor: cardColor ?? this.cardColor,
      dividerColor: dividerColor ?? this.dividerColor,
      hintColor: hintColor ?? this.hintColor,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      ThemeExtension<AppThemeExtension>? other,
      double t,
      ) {
    if (other is! AppThemeExtension) return this;

    return AppThemeExtension(
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

// Extension for easy access
extension ThemeExtras on ThemeData {
  AppThemeExtension get appColors => extension<AppThemeExtension>()!;
}