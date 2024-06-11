import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/assets.dart';

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog<T>({
  required BuildContext context,
  required String title,
  T? content,
  String? cancelActionText,
  String defaultActionText = AppStrings.okStr,
  Color defaultActionBg = AppColors.primaryColor400,
}) async {
  final btnWidth =
      (AppSizes.screenWidth / 2) - AppSizes.w26 - AppSizes.w20 - 24;

  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      elevation: 1,
      insetPadding: EdgeInsets.all(AppSizes.w26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyles.textBoldStyle16.copyWith(
          color: AppColors.gray600,
        ),
      ),
      content: content != null
          ? content is String
              ? Text(
                  textAlign: TextAlign.center,
                  content as String,
                  style: AppTextStyles.textRegularStyle14.copyWith(
                    color: AppColors.gray500,
                  ),
                )
              : content as Widget
          : null,
      actions: <Widget>[
        cancelActionText == null
            ? Center(
              child: PrimaryElevatedBtn(
                  background: defaultActionBg,
                  width: AppSizes.screenWidth > 800
                      ? AppSizes.screenWidth / 2
                      : AppSizes.screenWidth * 0.68,
                  text: defaultActionText,
                  press: () => Navigator.pop(context, true),
                ),
            )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryElevatedBtn(
                    height: AppSizes.length50,
                    background: defaultActionBg,
                    width: btnWidth,
                    text: defaultActionText,
                    press: () => Navigator.pop(context, true),
                  ),
                  gapH24,
                  PrimaryElevatedBtn(
                    height: AppSizes.length50,
                    background: AppColors.gray100,
                    textColor: AppColors.gray600,
                    width: btnWidth,
                    text: cancelActionText,
                    press: () => Navigator.pop(context, false),
                  ),
                ],
              ),
      ],
    ),
  );
}

Future<void> showSuccessAlertDialog({required BuildContext context}) {
  return showAlertDialog(
    context: context,
    title: AppStrings.successStr,
    content: SvgPicture.asset(
      Assets.icSuccess,
      width: getProportionateScreenHeight(56),
      height: getProportionateScreenHeight(56),
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) {
  return showAlertDialog(
    context: context,
    title: title,
    content: exception.toString(),
    defaultActionText: AppStrings.okStr,
  );
}
