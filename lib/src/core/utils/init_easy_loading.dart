import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constants/app_colors.dart';

void initEasyLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
  // ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
  // ..indicatorSize = 40.0
    ..radius = 10.0
    ..backgroundColor = AppColors.gray100
    ..indicatorColor = AppColors.primaryColor400
    ..indicatorWidget = const SizedBox(
      height: 100,
      width: 100,
      child: Center(child: CircularProgressIndicator()),
    )
    ..textColor = Colors.black87
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.custom;
}