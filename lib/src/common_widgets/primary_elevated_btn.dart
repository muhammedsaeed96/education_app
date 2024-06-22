import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_text_styles.dart';

class PrimaryElevatedBtn extends StatelessWidget {
  const PrimaryElevatedBtn({
    super.key,
    required this.text,
    required this.press,
    this.height,
    this.width = double.infinity,
    this.disable = false,
    this.background = AppColors.primaryColor400,
    this.textColor = Colors.white,
    this.radius,
  });

  final String text;
  final VoidCallback press;
  final double? height;
  final double width;
  final bool disable;
  final Color background;
  final Color textColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? getProportionateScreenHeight(50),
      width: width,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStatePropertyAll(
                disable ? AppColors.gray300 : background,
              ),
              shape: radius != null
                  ? MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius!),
                      ),
                    )
                  : null,
            ),
        onPressed: disable ? null : press,
        child: Text(
          text,
          style: AppTextStyles.textSemiBoldStyle14.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
