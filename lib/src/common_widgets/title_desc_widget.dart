import 'package:education_app/src/core/app_theme.dart';
import 'package:flutter/cupertino.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';

class TitleDescWidget extends StatelessWidget {
  const TitleDescWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.textSemiBoldStyle12,
        ),
        gap4,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: AppTheme.customDecoration(12),
          child: Text(
            description,
            style: AppTextStyles.textRegularStyle12
                .copyWith(color: AppColors.gray700),
          ),
        ),
      ],
    );
  }
}