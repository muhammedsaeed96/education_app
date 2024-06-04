import 'package:json_annotation/json_annotation.dart';

part 'app_info_model.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AppInfoModel{

  final String phone;
  final String facebookUrl;


  AppInfoModel({required this.phone , required this.facebookUrl});

  factory AppInfoModel.fromJson(Map<String, dynamic> data) =>
      _$AppInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);

}