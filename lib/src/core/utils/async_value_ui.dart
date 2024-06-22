import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/alert_dialogs.dart';

extension AsyncValueUi on AsyncValue {
  void showErrorDialog(BuildContext context) {
    if (hasError) {
      showExceptionAlertDialog(
        context: context,
        title: error.toString().contains('يرجى اعادة المحاولة بعد ')
            ? AppStrings.notifyStr
            : AppStrings.errorStr,
        exception: error,
      );
    }
  }
}
