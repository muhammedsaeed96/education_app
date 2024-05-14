import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_sizes.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.textBoldSlateStyle16);
  }
}


