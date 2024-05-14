import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'constants/app_text_styles.dart';

final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: AppColors.gray400, width: 1),
);

final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'NotoKufiArabic',
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1.0,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.gray500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 1.0,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    titleTextStyle: AppTextStyles.textSemiBoldSlateStyle18,
    centerTitle: true,
    elevation: 0,
    // to disable changing app bar color when scrolling a list
    scrolledUnderElevation: 0.0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: AppTextStyles.textMediumSlateStyle14.copyWith(
      color: AppColors.gray400,
    ),
    isDense: false,
    enabledBorder: outlineInputBorder,
    border: outlineInputBorder,
    focusedBorder: outlineInputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.green600, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
/*    errorStyle: AppTextStyles.textMediumSlateStyle12.copyWith(
      color: AppColors.red500,
    ),*/

  ),
);
