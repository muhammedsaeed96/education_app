import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common_widgets/custom_inkwell.dart';
import '../../../../core/constants/app_colors.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
    this.redColor = false,
  });

  final String title;
  final String icon;
  final VoidCallback press;
  final bool redColor;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      radius: 16,
      tap: press,
      child: Container(
        height: AppSizes.length54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gray100),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: AppSizes.length24,
              width: AppSizes.length24,
              colorFilter: redColor
                  ? const ColorFilter.mode(
                      AppColors.red500,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            gapH8,
            Text(
              title,
              style: AppTextStyles.textMediumStyle14.copyWith(
                color: redColor ? AppColors.red500 : AppColors.gray600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.gray600,
              size: AppSizes.length12,
            ),
          ],
        ),
      ),
    );
  }
}
