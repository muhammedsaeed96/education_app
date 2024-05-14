import 'package:flutter/material.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';

class DropDownMenuWidget extends StatelessWidget {
  const DropDownMenuWidget({
    super.key,
    this.currentVal,
    required this.hintText,
    required this.items,
    required this.onItemSelected,
    this.width,
  });

  final String? currentVal;
  final String hintText;
  final List<String> items;
  final void Function(String val) onItemSelected;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: currentVal,
      menuHeight: AppSizes.length204,
      width: width,
      hintText: hintText,
      textStyle: AppTextStyles.textMediumSlateStyle14,
      selectedTrailingIcon: Icon(
        Icons.keyboard_arrow_down,
        size: AppSizes.length20,
      ),
      trailingIcon: Icon(
        Icons.keyboard_arrow_up,
        size: AppSizes.length20,
      ),
      menuStyle: MenuStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onSelected: (val) => onItemSelected(val),
      dropdownMenuEntries: items.map<DropdownMenuEntry>(
        (String color) {
          return DropdownMenuEntry<String>(
            value: color,
            label: color,
            style: MenuItemButton.styleFrom(
              textStyle: AppTextStyles.textMediumSlateStyle14,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          );
        },
      ).toList(),
    );
  }
}
