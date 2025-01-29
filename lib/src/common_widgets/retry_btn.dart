import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

class RetryBtn extends StatelessWidget {
  const RetryBtn({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: press,
      icon: Icon(
        Icons.refresh_rounded,
        size: 20,
        color: AppColors.primaryColor400,
      ),
      label: Text(
        AppStrings.retryWithErrorStr,
        style: AppTextStyles.textMediumStyle14.copyWith(
          color: Colors.black87,
        ),
      ),
    );
  }
}
