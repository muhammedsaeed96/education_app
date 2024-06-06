import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';

class DropDownFormFieldWidget extends StatelessWidget {
  const DropDownFormFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.onChange,
    required this.items,
    this.selectedItem,
    this.needSetSelectedItem = false,
  });

  final String title;
  final String hintText;
  final void Function(dynamic) onChange;
  final List<dynamic> items;
  final String? selectedItem;
  final bool needSetSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: AppTextStyles.textRegularStyle14
                .copyWith(color: AppColors.black87),
            children: <InlineSpan>[
              TextSpan(
                text: ' *',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.red500),
              ),
            ],
          ),
        ),
        gap6,
        DropdownButtonFormField(
          menuMaxHeight: AppSizes.length204,
          elevation: 2,
          decoration: InputDecoration(hintText: hintText),
          dropdownColor: Colors.white,
          value:needSetSelectedItem ? _getSelectedItems : selectedItem,
          validator: (val) {
            final String? text = val as String?;
            return text.isValidText;
          },
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: items is List<String> ? e : e.id,
                  child: Text(
                    items is List<String> ? e : e.name,
                    style: AppTextStyles.textRegularStyle16
                        .copyWith(color: Colors.black),
                  ),
                ),
              )
              .toList(),
          onChanged: onChange,
          icon: Icon(Icons.keyboard_arrow_down, size: AppSizes.length20),
        ),
      ],
    );
  }

  String? get _getSelectedItems {
    if (selectedItem != null) {
      return selectedItem;
    } else {
      if (items.isNotEmpty) {
        if (items is List<String>) {
          return items[0];
        } else {
          return items[0].id;
        }
      } else {
        return null;
      }
    }

    selectedItem == null
        ? items.isNotEmpty
            ? (items is List<String> ? items[0] : items[0].id)
            : null
        : null;
  }
}
