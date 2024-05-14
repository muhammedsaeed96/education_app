import 'package:education_app/src/common_widgets/filters_bottom_sheet.dart';
import 'package:education_app/src/common_widgets/search_field.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/assets.dart';

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({
    super.key,
    required this.hintText,
    required this.type,
  });

  final TeachingType type;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SearchField(hintTextStr: hintText)),
        gapH6,
        IconButton(
          style: IconButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => filtersBottomSheet(context: context, type: type),
          icon: SvgPicture.asset(Assets.icFilter),
        ),
      ],
    );
  }
}
