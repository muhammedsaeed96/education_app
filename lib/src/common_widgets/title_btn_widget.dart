import 'package:education_app/src/common_widgets/title_widget.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class TitleBtnWidget extends StatelessWidget {
  const TitleBtnWidget({super.key, required this.title, required this.onPress});

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleWidget(title: title),
        TextButton(
          onPressed: onPress,
          child: Text(
            AppStrings.viewMoreStr,
            style: AppTextStyles.textSemiBoldSlateStyle12.copyWith(
              color: AppColors.green400,
            ),
          ),
        ),
      ],
    );
  }
}
