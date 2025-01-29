import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

bsTakePicture({
  required BuildContext context,
  required VoidCallback galleryPress,
  required VoidCallback cameraPress,
}) {

  final screenWidth = MediaQuery.sizeOf(context).width;

  return showModalBottomSheet<void>(
    context: context,
    builder: (_) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryElevatedBtn(
              width: double.infinity,
              press: galleryPress,
              text: AppStrings.galleryStr,
              background: AppColors.primaryColor400,
              radius: 24,
            ),
            gap12,
            OutlinedButton(
              onPressed: cameraPress,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                // backgroundColor: AppColors.primaryColor100,
                side: const BorderSide(color: AppColors.primaryColor400),
                fixedSize: Size(screenWidth, 48),
              ),
              child: Text(
                AppStrings.cameraStr,
                style: AppTextStyles.textSemiBoldStyle14.copyWith(
                  color: AppColors.primaryColor400,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
