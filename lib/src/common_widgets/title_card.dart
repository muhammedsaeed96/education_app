import 'package:education_app/src/core/app_theme.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: AppTheme.customDecoration(12),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.textRegularStyle12
              .copyWith(color: AppColors.gray700),
        ),
      ),
    );
  }
}
