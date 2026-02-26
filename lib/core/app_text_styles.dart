import 'package:flutter/material.dart';
import 'app_colors.dart';

/// TextTheme centralisé pour cohérence typographique.
class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    headlineLarge:  TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleMedium:    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    bodyMedium:     TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
    labelMedium:    TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
  );
}
