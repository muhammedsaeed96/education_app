import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/assets.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.hintTextStr});

  final String hintTextStr;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (p) => FocusManager.instance.primaryFocus?.unfocus(),
      style: AppTextStyles.textMediumSlateStyle14,
      controller: controller,
      onChanged: null,
      decoration: InputDecoration(
        hintText: widget.hintTextStr,
        prefixIconConstraints: BoxConstraints(
          minWidth: AppSizes.length24,
          minHeight: AppSizes.length24,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: SvgPicture.asset(Assets.icSearch),
        ),
      ),
    );
  }
}
