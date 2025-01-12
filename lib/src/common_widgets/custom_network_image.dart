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
    this.fit = BoxFit.cover,
    this.iconPath = Assets.icProfile,
    required this.iconSize,
  });

  final String? imageUrl;
  final File? file;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double? radius;
  final String iconPath;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 16),
        child: ColoredBox(color: AppColors.gray50, child: _renderImage()),
      ),
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
          errorBuilder: (context, _, stackTrace) => _imageNotLoaded(),
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor400,
                      strokeWidth: 3.0,
                    ),
                  );
          },
        ),
      );
    }

    return _imageNotLoaded();
  }

  Widget _imageNotLoaded() {
    return Center(
      child: SvgPicture.asset(
        iconPath,
        height: iconSize,
        width: iconSize,
        // fit: BoxFit.none,
      ),
    );
  }
}
