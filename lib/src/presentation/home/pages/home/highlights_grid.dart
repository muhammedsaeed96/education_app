import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/app_theme.dart';

class HighlightsGrid extends ConsumerWidget {
  const HighlightsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: AppSizes.length60,
      ),
      itemBuilder: (_, i) {
        final (title, iconPath, type) = AppStrings.highlights[i];

        return ZoomTapAnimation(
          onTap: () {
            ref.read(selectedHighlight.notifier).state = type;
            ref
                .read(filtersControllerProvider.notifier)
                .updateByHighlightType(type);
            return Navigator.pushNamed(
              context,
              TeachersScreen.routeName,
              arguments: type,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: AppTheme.customDecoration(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: AppSizes.length24,
                  height: AppSizes.length24,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor400,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.textMediumStyle14,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: AppStrings.highlights.length,
    );
  }
}
