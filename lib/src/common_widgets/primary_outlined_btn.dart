import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

class PrimaryOutlinedBtn extends StatelessWidget {
  const PrimaryOutlinedBtn({
    super.key,
    required this.text,
    required this.press,
    this.radius,
    this.borderColor,
    this.bg,
    this.height,
    this.width,
  });

  final String text;
  final VoidCallback press;

  final double? radius;
  final Color? borderColor;
  final Color? bg;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: borderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.textSemiBoldStyle14.copyWith(
            color: AppColors.gray500,
          ),
        ),
      ),
    );
  }
}
