import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.gray300, width: 1),
  );

  static final themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor400,
      surface: Colors.white,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: 'IBMPlexSansArabic',
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.5,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.gray500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1.0,
      ),
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: AppSizes.length64,
      color: Colors.white,
      titleTextStyle: AppTextStyles.textSemiBoldStyle18,
      centerTitle: true,
      // to disable changing app bar color when scrolling a list
      scrolledUnderElevation: 0.0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.textMediumStyle12.copyWith(
        color: AppColors.gray400,
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: false,
      enabledBorder: _outlineInputBorder,
      border: _outlineInputBorder,
      focusedBorder: _outlineInputBorder.copyWith(
        borderSide: const BorderSide(
          color: AppColors.primaryColor500,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      errorBorder: _outlineInputBorder,
      focusedErrorBorder: _outlineInputBorder,
/*    errorStyle: AppTextStyles.textMediumStyle12.copyWith(
      color: AppColors.red500,
    ),*/
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor400,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      showDragHandle: true,
      dragHandleColor: AppColors.gray400,
      dragHandleSize: Size(72, 5),
    ),
    cardColor: Colors.white,

    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      disabledColor: Colors.white,
      selectedColor: AppColors.primaryColor400,
      labelStyle: AppTextStyles.textSemiBoldStyle12,
    ),
  );

  static customDecoration([double radius = 16]) {
    return BoxDecoration(
      border: Border.all(color: AppColors.gray200, width: 0.5),
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
    );
  }
}
