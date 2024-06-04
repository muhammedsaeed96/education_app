import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_text_styles.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.noDataStr,
        style: AppTextStyles.textMediumStyle16,
      ),
    );
  }
}
