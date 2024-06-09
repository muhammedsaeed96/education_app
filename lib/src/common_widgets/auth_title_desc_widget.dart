import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class AuthTitleDescWidget extends StatelessWidget {
  const AuthTitleDescWidget(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.textSemiBoldStyle16.copyWith(color: Colors.black87),
        ),
        gap6,
        Text(
          description,
          style: AppTextStyles.textRegularStyle14.copyWith(
            color: AppColors.gray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
