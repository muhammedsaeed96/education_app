import 'dart:io';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/custom_network_image.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.imageUrl, this.imageFile});

  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.gray100,
      radius: AppSizes.length42,
      child: ClipOval(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: AppSizes.length42,
          child: _renderImage(),
        ),
      ),
    );
  }

  Widget _renderImage() {
    if (imageFile != null) {
      return Image.file(imageFile!);
    }

    return CustomNetworkImage(
      imageUrl: imageUrl,
      // localIcon: Assets.icUserRounded,
      radius: AppSizes.length80 / 2,
      width: AppSizes.length80,
      height: AppSizes.length80,
    );
  }
}
