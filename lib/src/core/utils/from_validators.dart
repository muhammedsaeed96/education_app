import 'package:education_app/src/core/constants/app_strings.dart';

extension FromValidators on String? {
  String? get isValidPhone {
    if (this != null &&
        this!.isNotEmpty &&
        (this!.length == 11 || this!.length == 10)) {
      return null;
    } else {
      return AppStrings.phoneNotValidStr;
    }
  }

  String? get isValidText {
    if (this != null && this!.isNotEmpty) {
      return null;
    } else {
      return AppStrings.requiredStr;
    }
  }

  String? get isValidDescription {
    if (this != null && this!.isNotEmpty && this!.length >= 10) {
      return null;
    } else {
      return AppStrings.tooShortDescriptionStr;
    }
  }

  String? get isValidUrl {
    if (this == null || this!.isEmpty) {
      return null;
    } else {
      return Uri.tryParse(this!)!.hasAbsolutePath ? null : AppStrings.notValidUrlStr;
    }
  }
}
