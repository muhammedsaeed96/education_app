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
  });

  final String title;
  final String hintText;
  final void Function(String?) onChange;
  final List<String> items;
  final String? selectedItem;

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
          value: selectedItem,
          validator: (val) => val.isValidText,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
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
}
