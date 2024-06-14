import 'package:flutter/material.dart';
import '../../../../common_widgets/custom_inkwell.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class VisitorsNumberCard extends StatelessWidget {
  const VisitorsNumberCard({super.key, required this.number});

  final String  number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingH24,
      child: CustomInkwell(
        tap: () {},
        radius: 12,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gray500,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  text: AppStrings.visitNumbersStr,
                  style: AppTextStyles.textSemiBoldStyle14
                      .copyWith(color: AppColors.black87),
                  children: <InlineSpan>[
                    TextSpan(
                        text: '  32',
                        style: AppTextStyles.textSemiBoldStyle18.copyWith(
                          color: AppColors.primaryColor600,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(12),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.primaryColor400,
                ),
                child: Text(
                  AppStrings.detailsStr,
                  style: AppTextStyles.textMediumStyle14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
