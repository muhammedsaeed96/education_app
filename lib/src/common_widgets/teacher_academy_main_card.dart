import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import 'adderss_widget.dart';
import 'custom_cached_network_image.dart';
import 'custom_inkwell.dart';

class TeacherAcademyMainCard extends StatelessWidget {
  const TeacherAcademyMainCard({
    super.key,
    required this.press,
    this.imageUrl,
    required this.title,
    required this.city,
    required this.region,
    required this.description,
    required this.visitorsNum,
  });

  final VoidCallback press;
  final String? imageUrl;
  final String title;
  final String city;
  final String region;
  final String description;
  final int visitorsNum;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      tap: press,
      radius: 16,
      child: Container(
        alignment: Alignment.bottomCenter,
        constraints: BoxConstraints(
          minWidth: AppSizes.length120,
          maxWidth: AppSizes.screenWidth * 0.5,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCachedNetworkImage(
                  imageUrl: imageUrl.getFullUrl,
                  height: AppSizes.length64,
                  width: AppSizes.length64,
                  radius: AppSizes.length64 / 2,
                ),
                gapH12,
                visitorsNum > 0
                    ? Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.gray50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.gray300,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            '${AppStrings.visitStr} : $visitorsNum',
                            style: AppTextStyles.textRegularStyle10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            gap12,
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textSemiBoldStyle12,
            ),
            gap6,
            AddressWidget(city: city, region: region),
            gap4,
            Expanded(
              child: Text(
                description,
                style: AppTextStyles.textRegularStyle12.copyWith(
                  color: AppColors.gray500,
                ),
                maxLines: AppSizes.screenHeight <= 640 ? 1 : 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
