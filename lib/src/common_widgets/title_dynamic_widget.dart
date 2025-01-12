import 'package:flutter/material.dart';
import '../core/constants/app_text_styles.dart';

class TitleDynamicWidget extends StatelessWidget {
  const TitleDynamicWidget(
      {super.key, required this.title, required this.widget});

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.textSemiBoldStyle12,
        ),
        widget,
      ],
    );
  }
}
