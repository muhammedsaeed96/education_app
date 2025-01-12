import 'package:flutter/cupertino.dart';
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.icMapFill,
          height: AppSizes.length16,
          width: AppSizes.length16,
        ),
        gapH6,
        Expanded(
          child: Text(
            region.isEmpty ? city : '$city / $region',
            style: AppTextStyles.textMediumStyle12.copyWith(
              color: AppColors.gray600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
