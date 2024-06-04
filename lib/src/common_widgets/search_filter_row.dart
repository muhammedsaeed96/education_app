import 'package:education_app/src/common_widgets/filters_bottom_sheet.dart';
import 'package:education_app/src/common_widgets/search_field.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
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

  final TeachingType type;
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
        gapH6,
        IconButton(
          style: IconButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            filtersBottomSheet(context: context, type: type);
          },
          icon: SvgPicture.asset(
            Assets.icFilter,
            colorFilter: ref.watch(filtersControllerProvider).hasValue
                ? const ColorFilter.mode(
                    AppColors.primaryColor400,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
