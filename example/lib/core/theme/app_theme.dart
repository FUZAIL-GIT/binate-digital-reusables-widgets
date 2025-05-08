import 'package:examples/core/theme/app_colors.dart';
import 'package:examples/core/theme/light/light_theme.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);

  static ThemeData lightThemeData = themeData(
    LightTheme.lightColorScheme,
    _lightFocusColor,
  );

  /// method to return the theme data
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      focusColor: focusColor,
      appBarTheme: AppBarTheme(
        elevation: 0,

        backgroundColor: colorScheme.surface,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.kWhite),
      ),
      datePickerTheme: DatePickerThemeData(dividerColor: colorScheme.tertiary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.kWhite.withValues(alpha: 0.15),
        counterStyle: TextStyle(
          fontFamily: 'Poppins-Regular',
          fontSize: 12,
          color: colorScheme.onPrimary.withValues(alpha: 0.7),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Poppins-Italic',
          fontSize: 16,
          color: colorScheme.onPrimary.withValues(alpha: 0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppColors.kWhite, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppColors.kWhite, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppColors.kWhite, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppColors.kRed, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppColors.kWhite, width: 1.5),
        ),
        outlineBorder: BorderSide(color: AppColors.kWhite, width: 1.5),
        activeIndicatorBorder: BorderSide(color: AppColors.kWhite, width: 1.5),
      ),
    );
  }
}
