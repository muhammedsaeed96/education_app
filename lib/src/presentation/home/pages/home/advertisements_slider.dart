import 'package:carousel_slider/carousel_slider.dart';
import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:education_app/src/model/advertisement_model.dart';
import 'package:education_app/src/presentation/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/zoom_tap_animation.dart';
import '../../../../common_widgets/custom_network_image.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/assets.dart';

class AdvertisementsSlider extends StatelessWidget {
  const AdvertisementsSlider({super.key, required this.advertisements});

  final List<AdvertisementModel> advertisements;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 148,
        viewportFraction: 0.9,
      ),
      items: advertisements.map((advertisement) {
        return Builder(
          builder: (BuildContext context) {
            final url = advertisement.imageUrl.getFullUrl;
            return ZoomTapAnimation(
              onTap: () {
                Navigator.of(context).pushNamed(
                  TeacherDetailsScreen.routeName,
                  arguments: advertisement.teacherOrAcademyId,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomNetworkImage(
                  imageUrl: url,
                  iconPath: Assets.icImageNotFound,
                  iconSize: AppSizes.length48,
                  radius: 16,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
