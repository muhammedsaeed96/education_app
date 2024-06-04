import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/assets.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.file,
    this.height,
    this.width,
    this.radius,
    this.iconHeight,
    this.iconWidth,
    this.fit = BoxFit.cover,
    this.assetImage = Assets.icProfile,
    this.assetImageBg = AppColors.gray200,
  });

  final String? imageUrl;
  final File? file;
  final double? height;
  final double? width;
  final double? iconHeight;
  final double? iconWidth;
  final BoxFit fit;
  final double? radius;
  final String assetImage;
  final Color assetImageBg;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: _renderImage(),
    );
  }

  _renderImage() {
    if (file != null) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
      );
    }
    if (imageUrl != null) {
      return ColoredBox(
        color: AppColors.gray200,
        child: Image.network(
          imageUrl!,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, _, stackTrace) => _notLoadImage(),
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : SizedBox(
                    height: height,
                    width: width,
                    child: const ColoredBox(
                      color: AppColors.gray200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor400,
                        ),
                      ),
                    ),
                  );
          },
        ),
      );
    }

    return _notLoadImage();
  }

  Widget _notLoadImage() {
    return SvgPicture.asset(assetImage, height: height, width: width);
  }
}
