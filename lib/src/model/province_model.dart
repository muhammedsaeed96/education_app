import 'package:education_app/src/model/area_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProvinceModel {
  final String id;
  final String name;
  @JsonKey(name: 'Areas')
  final List<AreaModel> areas;

  ProvinceModel({
    required this.id,
    required this.name,
    this.areas = const [],
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> data) =>
      _$ProvinceModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);
}
