import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

class CustomFileConverter implements JsonConverter<File, String> {
  const CustomFileConverter();

  @override
  File fromJson(String json) {
    Uri uri = Uri(path: json);
    return File.fromUri(uri);
  }

  @override
  String toJson(File json) => json.path.toString();
}
