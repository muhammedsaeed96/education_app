import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import 'adderss_widget.dart';
import 'custom_inkwell.dart';
import 'custom_network_image.dart';

class TeacherAcademyMainCard extends StatelessWidget {
  const TeacherAcademyMainCard({
    super.key,
    required this.press,
    this.imageUrl,
    required this.title,
    required this.city,
    required this.region,
    required this.description,
  });

  final VoidCallback press;
  final String? imageUrl;
  final String title;
  final String city;
  final String region;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      tap: press,
      radius: 12,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl,
              height: AppSizes.length64,
              width: AppSizes.length64,
              radius: AppSizes.length64 / 2,
            ),
            gap8,
            Text(
              title,
              style: AppTextStyles.textSemiBoldSlateStyle12,
            ),
            gap4,
            // TODO : EXTRACT IT IN WIDGET
            // to display teacher or academy city and region
            AddressWidget(city: city, region: region),
            gap8,
            Container(
              constraints: BoxConstraints(
                minWidth: AppSizes.length120,
                maxWidth: AppSizes.screenWidth * 0.5,
              ),
              child: Text(
                description,
                style: AppTextStyles.textMediumSlateStyle12.copyWith(
                  color: AppColors.gray500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
