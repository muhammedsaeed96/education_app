import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_text_styles.dart';

class MultiSelectDialogFormField extends StatelessWidget {
  const MultiSelectDialogFormField({
    super.key,
    required this.title,
    required this.items,
    required this.confirm,
    this.initialValue = const [],
    required this.btnText,
  });

  final String title;
  final List<dynamic> items;
  final void Function(List) confirm;
  final List initialValue;
  final String btnText;

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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gray300),
            color: Colors.white
          ),
          child: MultiSelectDialogField(
            backgroundColor: Colors.white,
            title: const SizedBox.shrink(),
            initialValue: initialValue,
            items: items.map((val) => MultiSelectItem(val.id, val.name)).toList(),
            listType: MultiSelectListType.LIST,
            chipDisplay: MultiSelectChipDisplay.none(),
/*            chipDisplay: MultiSelectChipDisplay(
              chipColor: AppColors.gray100,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),*/
            buttonText: Text(
              btnText,
              style: AppTextStyles.textMediumStyle14.copyWith(
                color: items.isEmpty ? AppColors.gray400 : Colors.black,
              ),
            ),
            dialogHeight: items.length > 3
                ? AppSizes.screenHeight * 0.5
                : AppSizes.length200,
            buttonIcon: Icon(
              Icons.keyboard_arrow_down,
              size: AppSizes.length20,
            ),
            itemsTextStyle:
                AppTextStyles.textRegularStyle18.copyWith(color: Colors.black),
            selectedItemsTextStyle:
                AppTextStyles.textRegularStyle18.copyWith(color: Colors.black),
            selectedColor: AppColors.primaryColor400,
            checkColor: Colors.white,
            decoration: const BoxDecoration(),
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
        ),
      ],
    );
  }
}
