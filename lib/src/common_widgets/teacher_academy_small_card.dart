import 'package:education_app/src/core/app_theme.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import 'adderss_widget.dart';
import 'custom_network_image.dart';

class TeacherAcademySmallCard extends StatelessWidget {
  const TeacherAcademySmallCard({
    super.key,
    required this.title,
    this.imageUrl,
    required this.city,
    required this.region,
    this.discount,
    this.discountEndDate,
    required this.press,
  });

  final String title;
  final String? imageUrl;
  final String city;
  final String region;
  final double? discount;
  final DateTime? discountEndDate;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: 0.97,
      onTap: press,
      child: Container(
        decoration: AppTheme.customDecoration(),
        padding: EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl.getFullUrl,
              height: AppSizes.length58,
              width: AppSizes.length58,
              iconSize: AppSizes.length58,
              radius: AppSizes.length58 / 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.textSemiBoldStyle12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  gap6,
                  AddressWidget(city: city, region: region),
                ],
              ),
            ),
            _formattedDiscount != null && _discountNotExpired
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.red400,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '% $_formattedDiscount',
                      style: AppTextStyles.textSemiBoldStyle12.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String? get _formattedDiscount {
    final formattedDiscount = discount != null && discount! > 0
        ? NumberFormat('#,###', 'en_US').format(discount?.round())
        : null;
    return formattedDiscount;
  }

  bool get _discountNotExpired {
    if (discountEndDate == null) {
      return false;
    }

    final now = DateTime.now().subtract(Duration(days: 1));

    return now.isBefore(discountEndDate!);
  }
}
