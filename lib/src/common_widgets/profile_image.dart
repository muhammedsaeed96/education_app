import 'dart:io';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/assets.dart';
import 'custom_network_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.imageUrl, this.imageFile});

  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return _renderImage();
  }

  Widget _renderImage() {
    if (imageFile != null) {
      return Image.file(imageFile!);
    } else if (imageUrl != null) {
      return CustomNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        radius: AppSizes.length80 / 2,
        width: AppSizes.length80,
        height: AppSizes.length80,
      );
    } else {
      return SvgPicture.asset(
        Assets.icProfile,
        height: AppSizes.length80,
        width: AppSizes.length80,
      );
    }
  }
}
