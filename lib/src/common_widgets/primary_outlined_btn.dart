import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

class PrimaryOutlinedBtn extends StatelessWidget {
  const PrimaryOutlinedBtn({
    super.key,
    required this.text,
    required this.press,
  });

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      child: Text(
        AppStrings.cancelStr,
        style: AppTextStyles.textSemiBoldSlateStyle14.copyWith(
          color: AppColors.gray500,
        ),
      ),
    );
  }
}
