import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';

class DropDownMenuWidget extends StatelessWidget {
  const DropDownMenuWidget({
    super.key,
    this.currentVal,
    this.hintText,
    required this.items,
    required this.onItemSelected,
    this.width,
  });

  final String? currentVal;
  final String? hintText;
  final List<dynamic> items;
  final void Function(String val) onItemSelected;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final entry = items.map<DropdownMenuEntry>(
      (value) {
        return DropdownMenuEntry<String>(
          value: value.id,
          label: value.name,
          style: MenuItemButton.styleFrom(
            textStyle: AppTextStyles.textRegularStyle16.copyWith(
              color: Colors.black,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        );
      },
    ).toList();

    return DropdownMenu(
      initialSelection: currentVal,
      width: width,
      hintText: hintText,
      textStyle: AppTextStyles.textMediumStyle14,
      menuHeight: items.length >= 15 ? AppSizes.screenHeight * 0.9 : null,
      selectedTrailingIcon: Icon(
        Icons.keyboard_arrow_down,
        size: AppSizes.length20,
      ),
      trailingIcon: Icon(
        Icons.keyboard_arrow_up,
        size: AppSizes.length20,
      ),
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        constraints: BoxConstraints.tight(const Size.fromHeight(48)),
      ),
      onSelected: (val) => onItemSelected(val),
      dropdownMenuEntries: entry,
    );
  }
}
