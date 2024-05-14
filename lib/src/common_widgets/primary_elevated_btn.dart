import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_text_styles.dart';

class PrimaryElevatedBtn extends StatelessWidget {
  const PrimaryElevatedBtn({
    super.key,
    required this.text,
    required this.press,
    this.height = 50,
    this.width = double.infinity,
    this.disable = false,
  });

  final String text;
  final VoidCallback press;
  final double height;
  final double width;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: disable
                  ? const MaterialStatePropertyAll(
                      AppColors.gray400,
                    )
                  : null,
            ),
        onPressed: press,
        child: Text(
          text,
          style: AppTextStyles.textSemiBoldSlateStyle14.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
