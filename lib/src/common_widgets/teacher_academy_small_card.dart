import 'package:education_app/src/core/constants/api_urls.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';
import 'adderss_widget.dart';
import 'custom_inkwell.dart';
import 'custom_network_image.dart';

class TeacherAcademySmallCard extends StatelessWidget {
  const TeacherAcademySmallCard({
    super.key,
    required this.title,
    this.imageUrl,
    required this.city,
    required this.region,
    required this.press,
  });

  final String title;
  final String? imageUrl;
  final String city;
  final String region;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      tap: press,
      radius: 16,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          minVerticalPadding: 20,
          leading: CustomNetworkImage(
            imageUrl: '${ApiUrls.baseUrl}/$imageUrl',
            height: AppSizes.length58,
            width: AppSizes.length58,
            radius:AppSizes.length58 / 2,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              title,
              style: AppTextStyles.textSemiBoldStyle12,
            ),
          ),
          subtitle: AddressWidget(city: city, region: region),
        ),
      ),
    );
  }
}