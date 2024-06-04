
import '../constants/api_urls.dart';

extension StringExtension on String? {
  String? get getFullUrl {
    if (this == null) {
      return null;
    }
    return '${ApiUrls.baseUrl}/$this';
  }
}
