import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/assets.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.errorMessage,
    required this.retry,
    this.showOnlyText = true,
  });

  final String errorMessage;
  final bool showOnlyText;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            Assets.icError,
            width: 160,
            height: 160,
          ),
          Text(
            errorMessage,
            style: AppTextStyles.textMediumStyle16,
            textAlign: TextAlign.center,
          ),
          gap16,
          Center(
            child: PrimaryElevatedBtn(
              height: 40,
              text: AppStrings.retryStr,
              width: 200,
              press: retry,
            ),
          ),
        ],
      ),
    );
  }
}
