import 'package:education_app/src/core/app_theme.dart';
import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/assets.dart';
import 'adderss_widget.dart';
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
    return ZoomTapAnimation(
      end: 0.97,
      onTap: press,
      child: Container(
        alignment: Alignment.bottomCenter,
        constraints: BoxConstraints(
          maxWidth: AppSizes.screenWidth * 0.62,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: AppTheme.customDecoration(),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              minVerticalPadding: 0,
              visualDensity: VisualDensity(horizontal: 0, vertical: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: SizedBox.fromSize(
                size: Size(AppSizes.length58, AppSizes.length58),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor50,
                    borderRadius: BorderRadius.circular(AppSizes.length58 / 2),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: imageUrl.getFullUrl,
                    height: AppSizes.length58,
                    width: AppSizes.length58,
                    iconSize: AppSizes.length58,
                    radius: AppSizes.length58 / 2,
                  ),
                ),
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textSemiBoldStyle12,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  description,
                  style: AppTextStyles.textRegularStyle12.copyWith(
                    color: AppColors.gray600,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
            Divider(
              color: AppColors.gray200,
              thickness: 0.68,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: AddressWidget(city: city, region: region)),
                  visitorsNum > 0
                      ? Row(
                          spacing: 4,
                          children: [
                            SvgPicture.asset(
                              Assets.icEyeFill,
                              height: AppSizes.length16,
                              width: AppSizes.length16,
                            ),
                            Text(
                              '$visitorsNum',
                              style: AppTextStyles.textMediumStyle12.copyWith(
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
