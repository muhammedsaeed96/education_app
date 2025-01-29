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
  final screenWidth = MediaQuery.sizeOf(context).width;

  final btnWidth = (screenWidth / 2) - 26 - 20 - 24;

  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      elevation: 1,
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyles.textBoldStyle16.copyWith(
          color: AppColors.black87,
        ),
      ),
      content: content != null
          ? content is String
              ? Text(
                  textAlign: TextAlign.center,
                  content as String,
                  style: AppTextStyles.textRegularStyle14.copyWith(
                    color: AppColors.gray700,
                  ),
                )
              : content as Widget
          : null,
      actions: <Widget>[
        cancelActionText == null
            ? Center(
                child: PrimaryElevatedBtn(
                  background: defaultActionBg,
                  width:
                      screenWidth > 800 ? screenWidth / 2 : screenWidth * 0.72,
                  text: defaultActionText,
                  press: () => Navigator.pop(context, true),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryElevatedBtn(
                    radius: 16,
                    height: AppSizes.length46,
                    background: AppColors.gray200,
                    textColor: AppColors.gray600,
                    width: btnWidth,
                    text: cancelActionText,
                    press: () => Navigator.pop(context, false),
                  ),
                  gapH4,
                  PrimaryElevatedBtn(
                    radius: 16,
                    height: AppSizes.length46,
                    background: defaultActionBg,
                    width: btnWidth,
                    text: defaultActionText,
                    press: () => Navigator.pop(context, true),
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
    content: SvgPicture.asset(Assets.icSuccess, width: 56, height: 56),
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

Future<bool?> loginAlertDialog<T>({
  required BuildContext context,
  required String content,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      elevation: 1,
      insetPadding: EdgeInsets.all(26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        AppStrings.notifyStr,
        textAlign: TextAlign.center,
        style: AppTextStyles.textBoldStyle16.copyWith(
          color: AppColors.black87,
        ),
      ),
      content: Text(
        textAlign: TextAlign.center,
        content,
        style: AppTextStyles.textRegularStyle12.copyWith(
          color: AppColors.gray700,
        ),
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PrimaryElevatedBtn(
              radius: 16,
              height: AppSizes.length45,
              background: AppColors.primaryColor400,
              width: double.infinity,
              text: AppStrings.loginStr,
              press: () => Navigator.pop(context, true),
            ),
            gap12,
            PrimaryElevatedBtn(
              radius: 16,
              height: AppSizes.length45,
              background: AppColors.gray200,
              textColor: AppColors.gray600,
              width: double.infinity,
              text: AppStrings.cancelStr,
              press: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ],
    ),
  );
}
