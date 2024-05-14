import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class MultiSelectDialogFormField extends StatelessWidget {
  const MultiSelectDialogFormField({
    super.key,
    required this.title,
    required this.items,
    required this.confirm,
  });

  final String title;
  final List<String> items;
  final void Function(List<dynamic>?) confirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.black87),
            children: <InlineSpan>[
              TextSpan(
                text: '*',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.red500),
              ),
            ],
          ),
        ),
        gap6,
        MultiSelectDialogField(
          title: const SizedBox.shrink(),
          items: items.map((val) => MultiSelectItem(val, val)).toList(),
          listType: MultiSelectListType.LIST,
          chipDisplay: MultiSelectChipDisplay.none(),
          dialogHeight: items.length > 3
              ? AppSizes.screenHeight * 0.5
              : AppSizes.length200,
          buttonIcon: Icon(Icons.keyboard_arrow_down, size: AppSizes.length20),
          itemsTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.black87),
          selectedItemsTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.black87),
          selectedColor: AppColors.primaryColor,
          checkColor: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gray400),
          ),
          cancelText: const Text(AppStrings.cancelStr),
          confirmText: const Text(AppStrings.saveStr),
          onConfirm: confirm,
          validator: (items) {
            if (items != null && items.isNotEmpty) {
              return null;
            } else {
              return AppStrings.requiredStr;
            }
          },
        ),
      ],
    );
  }
}
