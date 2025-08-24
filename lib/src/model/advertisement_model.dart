import 'package:json_annotation/json_annotation.dart';

part 'advertisement_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvertisementModel {
  final String teacherOrAcademyId;
  final String imageUrl;

  AdvertisementModel({
    required this.teacherOrAcademyId,
    required this.imageUrl,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> data) =>
      _$AdvertisementModelFromJson(data);

  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);
}
