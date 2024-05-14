/*
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym/core/utils/constants/assets_path.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../controllers/storage_controller.dart';

class CustomNetworkImgProvider extends StatelessWidget {
  CustomNetworkImgProvider({
    super.key,
    this.imageUrl,
    this.child,
    required this.height,
    required this.width,
    required this.radius,
    this.file,
  });

  final String? imageUrl;
  final File? file;
  final Widget? child;
  final double height;
  final double width;
  final double radius;

  final _controller = Get.find<StorageController>();

  @override
  Widget build(BuildContext context) {
    return _renderImage();
  }

  Widget _renderImage() {
    if (file != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(file!),
      );
    } else if (imageUrl == null) {
      return _imageAsset();
    } else {
      return CachedNetworkImage(
        width: width,
        imageUrl: imageUrl!,
        httpHeaders: {
          HttpHeaders.authorizationHeader: _controller.token.value,
        },
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
        placeholder: (context, url) => Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkRiftColor_100,
              borderRadius: BorderRadius.circular(radius),
            ),
            height: height,
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColorPurple,
              ),
            ),
          ),
        ),
        errorWidget: (_, url, err) => _imageAsset(),
      );
    }
  }

  Widget _imageAsset() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.transparent,
      ),
      height: height,
      width: width,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AssetsPath.icMaleProfile,
        width: width,
        height: height,
      ),
    );
  }
}
*/
