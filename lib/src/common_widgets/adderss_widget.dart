import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/assets.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.city, required this.region});

  final String city;
  final String region;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          Assets.icMapFill,
          height: AppSizes.length18,
          width: AppSizes.length18,
        ),
        gapH6,
        Text(
          '$city / $region',
          style: AppTextStyles.textMediumSlateStyle12.copyWith(
            color: AppColors.gray500,
          ),
        ),
      ],
    );
  }
}
