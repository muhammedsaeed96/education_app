import 'package:json_annotation/json_annotation.dart';

part 'update_info_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UpdateInfoModel {
  final String versionAndroid;
  final String versionIos;
  final String appStoreUrl;
  final String playStoreUrl;

  UpdateInfoModel({
    required this.versionAndroid,
    required this.versionIos,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });

  factory UpdateInfoModel.fromJson(Map<String, dynamic> data) =>
      _$UpdateInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$UpdateInfoModelToJson(this);
}
