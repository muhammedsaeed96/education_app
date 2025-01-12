import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_text_styles.dart';
import '../core/constants/assets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.text = AppStrings.noDataStr,
    this.showTextOnly = false,
  });

  final String text;
  final bool showTextOnly;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: showTextOnly
          ? Text(
              text,
              style: AppTextStyles.textMediumStyle18,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.icNoSearchResults,
                  width: AppSizes.screenHeight * 0.16,
                  height: AppSizes.screenHeight * 0.16,
                ),
                // gap16,
                Text(
                  text,
                  style: AppTextStyles.textMediumStyle16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
