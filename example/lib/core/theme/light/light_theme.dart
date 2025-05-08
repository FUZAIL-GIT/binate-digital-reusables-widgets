import 'package:examples/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.kPrimaryRed,
    onPrimary: AppColors.kWhite,
    secondary: AppColors.kOrange,
    onSecondary: AppColors.kWhite,
    error: AppColors.kRed,
    onError: AppColors.kWhite,
    surface: AppColors.kWhite,
    onSurface: AppColors.kBlack,
    tertiary: AppColors.kDarkGrey,
    onTertiary: AppColors.kWhite,
    surfaceContainerHighest: AppColors.kLightGrey,
    brightness: Brightness.light,
  );
}
