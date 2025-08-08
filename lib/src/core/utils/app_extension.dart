import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';

import '../constants/api_urls.dart';

extension StringExtension on String? {
  String? get getFullUrl {
    if (this == null) {
      return null;
    }
    return '${ApiUrls.baseUrl}/$this';
  }

  String get getFullPhone => '+964${this!.substring(1)}';
}

extension EnumExtension on Enum? {
  String get getTeachersScreenAppbarTitle {
    if (this == HighlightType.outstanding) {
      return AppStrings.outstandingCurriculum;
    }

    if (this == HighlightType.discount) {
      return AppStrings.discounts;
    }

    if (this == HighlightType.onsite) {
      return AppStrings.homeTeaching;
    }

    if (this == HighlightType.online) {
      return AppStrings.onlineTeaching;
    }

    return AppStrings.teachersStr;
  }

  bool get isSearchOnTeacher => this == SearchType.teacher;
}
