import 'dart:io';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import '../core/constants/assets.dart';
import 'custom_network_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.imageUrl, this.imageFile});

  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.length80 / 2,
      backgroundImage: AssetImage(Assets.icProfile),
    );
  }

  Widget _renderImage() {
    if (imageFile != null) {
      return Image.file(imageFile!);
    }

    return CustomNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      radius: AppSizes.length80 / 2,
      width: AppSizes.length80,
      height: AppSizes.length80,
    );
  }
}
