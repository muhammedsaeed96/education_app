import 'package:education_app/src/core/constants/app_sizes.dart';
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
        child: ListTile(
          horizontalTitleGap: 8,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
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
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: redColor ? AppColors.red500 : AppColors.gray700),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.gray600,
            size: AppSizes.length16,
          ),
        ),
      ),
    );
  }
}
