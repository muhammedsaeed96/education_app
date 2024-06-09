
import '../constants/api_urls.dart';

extension StringExtension on String? {
  String? get getFullUrl {
    if (this == null) {
      return null;
    }
    return '${ApiUrls.baseUrl}/$this';
  }

  String get getFullPhone {
    if (this!.length == 10) {
      return '+964$this';
    } else {
      return '+964${this!.substring(1)}';
    }
}

}
