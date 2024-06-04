import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
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
          ? Text(
              textAlign: TextAlign.center,
              content,
              style: AppTextStyles.textMediumStyle14.copyWith(
                color: AppColors.gray500,
              ),
            )
          : null,
      actions: <Widget>[
        cancelActionText == null
            ? PrimaryElevatedBtn(
                background: defaultActionBg,
                text: defaultActionText,
                press: () => Navigator.pop(context, true),
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
                    background: AppColors.gray50,
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

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: AppStrings.okStr,
    );
