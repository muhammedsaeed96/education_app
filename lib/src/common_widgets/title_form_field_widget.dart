import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class TitleFormFiledWidget extends StatelessWidget {
  const TitleFormFiledWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isPhone = false,
    this.isRequired = true,
    this.maxLines = 1,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPhone;
  final bool isRequired;
  final int maxLines;

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
                text: validator != null && isRequired ? ' *' : ' (اختياري)',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: validator != null && isRequired
                          ? AppColors.red500
                          : AppColors.gray600,
                    ),
              ),
            ],
          ),
        ),
        gap6,
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          textDirection: isPhone ? TextDirection.ltr : null,
          textAlign: isPhone ? TextAlign.left : TextAlign.right,
          style: AppTextStyles.textRegularStyle14.copyWith(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: _buildSuffix(),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
          inputFormatters:
              isPhone ? [FilteringTextInputFormatter.digitsOnly] : [],
          keyboardType: isPhone ? TextInputType.phone : null,
          validator: validator,
          maxLength: isPhone ? 11 : null,
        ),
      ],
    );
  }

  Container? _buildSuffix() {
    return isPhone
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            width: getProportionateScreenWidth(54),
            alignment: Alignment.center,
            child: Text(
              '+964',
              textDirection: TextDirection.ltr,
              style: AppTextStyles.textMediumStyle14,
            ),
          )
        : null;
  }
}
