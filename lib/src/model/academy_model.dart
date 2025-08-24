import 'dart:io';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/custom_file_converter.dart';
import 'package:education_app/src/model/province_model.dart';
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
  final String? phone;
  final String? imageUrl;
  @CustomFileConverter()
  final File? image;
  final String? description;
  @JsonKey(name: 'Province')
  final ProvinceModel? province;
  @JsonKey(name: 'Area')
  final AreaModel? area;
  final String? locationDescription;
  @JsonKey(name: 'Stages')
  final List<StageModel> stages;
  final int visitorsNumber;
  final List<String> stagesIds;
  final List<ProvinceModel> provinces;
  final List<StageModel> allStages;
  final String? provinceId;
  final String? areaId;
  final String? facebookUrl;
  final String? youtubeUrl;
  final String? instagramUrl;
  final String? telegramUrl;
  final String? status;

  AcademyModel({
    required this.id,
    required this.title,
    this.phone,
    this.imageUrl,
    this.image,
    this.description,
    this.province,
    this.area,
    this.locationDescription,
    this.stages = const [],
    this.visitorsNumber = 0,
    this.stagesIds = const [],
    this.provinces = const [],
    this.allStages = const [],
    this.provinceId,
    this.areaId,
    this.facebookUrl,
    this.youtubeUrl,
    this.instagramUrl,
    this.telegramUrl,
    this.status,
  });

  @override
  int get hashCode => Object.hash(
    title.hashCode,
    provinceId.hashCode,
    areaId.hashCode,
    description.hashCode,
    locationDescription.hashCode,
    facebookUrl.hashCode,
    youtubeUrl.hashCode,
    instagramUrl.hashCode,
    telegramUrl.hashCode,
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
        facebookUrl: academyModel.facebookUrl,
        youtubeUrl: academyModel.youtubeUrl,
        instagramUrl: academyModel.instagramUrl,
        telegramUrl: academyModel.telegramUrl,
      );
    }
    return this;
  }

  factory AcademyModel.fromJson(Map<String, dynamic> data) =>
      _$AcademyModelFromJson(data);

  Map<String, dynamic> toJson() => _$AcademyModelToJson(this);

  static final dummyAcademies = [
    AcademyModel(
      id: '1',
      imageUrl: '',
      title: 'academy',
      province: ProvinceModel(id: '1', name: 'baghdad'),
      area: AreaModel(id: '1', name: 'test'),
      description: 'test description',
      visitorsNumber: 600,
    ),
    AcademyModel(
      id: '2',
      imageUrl: '',
      title: 'academy',
      province: ProvinceModel(id: '1', name: 'baghdad'),
      area: AreaModel(id: '1', name: 'test'),
      description: 'est description',
      visitorsNumber: 32,
    ),
    AcademyModel(
      id: '3',
      imageUrl: '',
      title: 'academy',
      province: ProvinceModel(id: '1', name: 'baghdad'),
      area: AreaModel(id: '1', name: 'test'),
      description: 'est description',
      visitorsNumber: 100,
    ),
  ];
}
