import 'dart:ui';

import 'package:flutter/widgets.dart';

class AppColors {
   static const Color teal100 =  Color(0xFFE6F6F4);
   static const Color teal200 =  Color(0xFFD9F2EF);
   static const Color teal300 =  Color(0xFFB0E4DD);
   static const Color teal400 =  Color(0xFF00A991);
   static const Color teal500 =  Color(0xFF009883);
   static const Color teal600 =  Color(0xFF008774);

   static const Color green50 =  Color(0xFFF2F9F8);
   static const Color green100 =  Color(0xFF00CCAF);
   static const Color green200 =  Color(0xFF00B399);
   static const Color green300 =  Color(0xFF009983);
   static const Color green400 =  Color(0xFF007F6D);
   static const Color green500 =  Color(0xFF006557);
   static const Color green600 =  Color(0xFF004C41);
   static const Color primaryColor =  Color(0xFF0F807E);


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

   static const Color red100 =  Color(0xFFE39386);
   static const Color red500 =  Color(0xFFF44646);

   static LinearGradient tealGradient = const LinearGradient(
      colors: [
         AppColors.teal500,
         AppColors.primaryColor,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight,
   );

}