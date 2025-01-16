import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

class FormTypeSwitcher extends StatelessWidget {
  const FormTypeSwitcher({
    super.key,
    required this.title,
    required this.btnText,
    required this.press,
  });

  final String title;
  final String btnText;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.textMediumStyle16.copyWith(color: AppColors.gray500),
        ),
        gapH4,
        TextButton(
          onPressed: press,
          child: Text(
            btnText,
            style: AppTextStyles.textMediumStyle16.copyWith(
                  color: AppColors.primaryColor400,
                  // decoration: TextDecoration.underline,
                ),
          ),
        )
      ],
    );
  }
}
