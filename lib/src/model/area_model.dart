import 'package:education_app/src/model/province_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'area_model.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AreaModel{
  final String id;
  final String name;


  AreaModel({required this.id , required this.name});

  factory AreaModel.fromJson(Map<String, dynamic> data) =>
      _$AreaModelFromJson(data);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);


static  List<AreaModel> getAreasByProvinceId({
    required List<ProvinceModel> provinces,
    required String? provinceId,
  }) {
    final List<AreaModel> areas = provinceId != null
        ? provinces
        .firstWhere(
          (p) => p.id == provinceId,
    )
        .areas
        : [];
    return areas;
  }

}