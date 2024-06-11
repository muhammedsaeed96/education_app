import 'dart:io';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/custom_file_converter.dart';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/social_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'academy_model.g.dart';

typedef AcademyID = String;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AcademyModel {
  final String id;
  @JsonKey(name: 'name')
  final String title;
  final String phone;
  final String? imageUrl;
  @CustomFileConverter()
  final File? image;
  final String description;
  @JsonKey(name: 'Province')
  final ProvinceModel? province;
  @JsonKey(name: 'Area')
  final AreaModel? area;
  final String locationDescription;
  @JsonKey(name: 'Stages')
  final List<StageModel> stages;
  final int visitorsNumber;
  final List<SocialModel> socials;
  final List<String> stagesIds;
  final List<ProvinceModel> provinces;
  final List<StageModel> allStages;
  final String? provinceId;
  final String? areaId;

  AcademyModel({
    required this.id,
    required this.title,
    required this.phone,
    this.imageUrl,
    this.image,
    required this.description,
    this.province,
    this.area,
    required this.locationDescription,
    this.stages = const [],
    this.visitorsNumber = 0,
    this.socials = const [],
    this.stagesIds = const [],
    this.provinces = const [],
    this.allStages = const [],
    this.provinceId,
    this.areaId,
  });

  @override
  int get hashCode => Object.hash(
        title.hashCode,
        provinceId.hashCode,
        areaId.hashCode,
        description.hashCode,
        locationDescription.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AcademyModel &&
            other.runtimeType == runtimeType &&
            other.hashCode == hashCode &&
            listEquals(other.stagesIds, stagesIds) == true;
  }

  AcademyModel copyWithNewAccountData(Object academyModel) {
    if (academyModel is AcademyModel) {
      return AcademyModel(
        id: id,
        title: academyModel.title,
        phone: phone,
        imageUrl: imageUrl,
        description: academyModel.description,
        locationDescription: academyModel.locationDescription,
        stagesIds: academyModel.stagesIds,
        provinces: provinces,
        allStages: allStages,
        provinceId: academyModel.provinceId,
        areaId: academyModel.areaId,
      );
    }
    return this;
  }

  factory AcademyModel.fromJson(Map<String, dynamic> data) =>
      _$AcademyModelFromJson(data);

  Map<String, dynamic> toJson() => _$AcademyModelToJson(this);
}
