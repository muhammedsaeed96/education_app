import 'dart:io';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = AppStrings.okStr,
}) async {
  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    // * AlertDialog.adaptive was added in Flutter 3.13
    builder: (context) => AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(title),
      content: content != null ? Text(content) : null,
      // * Use [TextButton] or [CupertinoDialogAction] depending on the platform
      actions: kIsWeb || !Platform.isIOS
          ? <Widget>[
              TextButton(
                child: Text(defaultActionText),
                onPressed: () => Navigator.pop(context, true),
              ),
              if (cancelActionText != null)
                TextButton(
                  child: Text(cancelActionText),
                  onPressed: () => Navigator.pop(context, false),
                ),
            ]
          : <Widget>[
              CupertinoDialogAction(
                child: Text(defaultActionText),
                onPressed: () => Navigator.pop(context, true),
              ),
              if (cancelActionText != null)
                CupertinoDialogAction(
                  child: Text(cancelActionText),
                  onPressed: () => Navigator.pop(context, false),
                ),
            ],
    ),
  );
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: AppStrings.okStr,
    );

/*
Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented',
    );
*/
