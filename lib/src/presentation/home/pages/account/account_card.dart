import 'package:education_app/src/core/app_theme.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common_widgets/zoom_tap_animation.dart';
import '../../../../core/constants/app_colors.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.press,
    this.redColor = false,
  });

  final String title;
  final String? description;
  final String icon;
  final VoidCallback press;
  final bool redColor;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: AppTheme.customDecoration(),
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
            gapH12,
            Expanded(
              child: description == null
                  ? Text(
                      title,
                      style: AppTextStyles.textMediumStyle14.copyWith(
                        color: redColor ? AppColors.red500 : AppColors.gray600,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.textMediumStyle14.copyWith(
                            color:
                                redColor ? AppColors.red500 : AppColors.gray600,
                          ),
                        ),
                        Text(
                          description!,
                          style: AppTextStyles.textRegularStyle12.copyWith(
                            color:
                                redColor ? AppColors.red500 : AppColors.gray500,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.black87,
              size: AppSizes.length14,
            ),
          ],
        ),
      ),
    );
  }
}
