import 'package:education_app/src/common_widgets/search_field.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/assets.dart';

class SearchFilterRow extends ConsumerWidget {
  const SearchFilterRow({
    super.key,
    required this.hintText,
    required this.type,
  });

  final SearchType type;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            hintTextStr: hintText,
            type: type,
          ),
        ),
        gapH10,
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              FilterScreen.routeName,
              arguments: type,
            );
          },
          child: SvgPicture.asset(
            Assets.icFilter,
            colorFilter: ColorFilter.mode(
              ref.watch(filtersControllerProvider).hasValue
                  ? AppColors.primaryColor400
                  : AppColors.gray500,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ), // icon of the button
          style: ElevatedButton.styleFrom(
            // styling the button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: ref.watch(filtersControllerProvider).hasValue
                    ? AppColors.primaryColor400
                    : AppColors.gray400,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.white, // Button color
          ),
        ),
      ],
    );
  }
}
