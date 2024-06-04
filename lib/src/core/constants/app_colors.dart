import 'dart:ui';

import 'package:flutter/widgets.dart';

class AppColors {

  static const Color primaryColor100 = Color(0xFF5fd1d1);
  static const Color primaryColor200 = Color(0xFF4bcbcb);
  static const Color primaryColor300 = Color(0xFF39c4c4);
  static const Color primaryColor400 = Color(0xFF33b0b0);
  static const Color primaryColor500 = Color(0xFF2d9c9c);
  static const Color primaryColor600 = Color(0xFF288888);
  static const Color primaryColor700 = Color(0xFF227575);

  ///black with opacity
  static Color black87 = const Color(0x00000000).withOpacity(0.87);
  static Color black60 = const Color(0x00000000).withOpacity(0.6);
  static Color black37 = const Color(0x00000000).withOpacity(0.37);
  static Color black14 = const Color(0x00000000).withOpacity(0.14);

  ///gray
  static const gray50 = Color(0xFFFAFAFA);
  static const gray100 = Color(0xFFF5F5F5);
  static const gray200 = Color(0xFFEEEEEE);
  static const gray300 = Color(0xFFE1E1E1);
  static const gray400 = Color(0xFFCACACA);
  static const gray500 = Color(0xFF8E8E8E);
  static const gray600 = Color(0xFF4B4B4B);
  static const gray700 = Color(0xFF1F1F1F);

  static const Color red100 = Color(0xFFE39386);
  static const Color red500 = Color(0xFFb91c1c);

  static LinearGradient tealGradient = const LinearGradient(
    colors: [
      AppColors.primaryColor400,
      AppColors.primaryColor500,
    ],
    begin: Alignment.topRight,
    end: Alignment.centerLeft,
  );
}
