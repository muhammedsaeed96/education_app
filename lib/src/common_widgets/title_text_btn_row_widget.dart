import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class TitleTextBtnRowWidget extends StatelessWidget {
  const TitleTextBtnRowWidget({
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
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.gray500),
        ),
        gapH4,
        TextButton(
          onPressed: press,
          child: Text(
            btnText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.green500,
                  // decoration: TextDecoration.underline,
                ),
          ),
        )
      ],
    );
  }
}
