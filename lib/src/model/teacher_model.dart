import 'dart:io';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../core/enum.dart';
import 'area_model.dart';
import 'custom_file_converter.dart';

part 'teacher_model.g.dart';

typedef TeacherID = String;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TeacherModel {
  final String id;
  final String name;
  final String? phone;
  final String? imageUrl;
  @CustomFileConverter()
  final File? image;
  final String? description;
  final String? locationDescription;
  @JsonKey(name: 'Subjects')
  final List<SubjectModel> subjects;
  final String? provinceId;
  final String? areaId;
  final List<String> subjectsIds;
  final List<String> stagesIds;
  @JsonKey(name: 'Province')
  final ProvinceModel? province;
  @JsonKey(name: 'Area')
  final AreaModel? area;
  @JsonKey(name: 'Stages')
  final List<StageModel> stages;
  final int visitorsNumber;
  final List<ProvinceModel> provinces;
  final List<StageModel> allStages;
  final List<SubjectModel> allSubjects;
  final String? facebookUrl;
  final String? youtubeUrl;
  final String? instagramUrl;
  final String? telegramUrl;
  final String? teachingType;
  final bool outstandingTeaching;
  final bool teachingOnStudentHome;
  final double discount;
  final DateTime? discountEndDate;
  final String? status;

  TeacherModel({
    required this.id,
    required this.name,
    this.phone,
    this.imageUrl,
    this.image,
    this.description,
    this.province,
    this.area,
    this.locationDescription,
    this.subjects = const [],
    this.stages = const [],
    this.visitorsNumber = 0,
    this.subjectsIds = const [],
    this.stagesIds = const [],
    this.provinceId,
    this.areaId,
    this.provinces = const [],
    this.allStages = const [],
    this.allSubjects = const [],
    this.facebookUrl,
    this.youtubeUrl,
    this.instagramUrl,
    this.telegramUrl,
    required this.teachingType,
    this.outstandingTeaching = false,
    this.teachingOnStudentHome = false,
    this.discount = 0.0,
    this.discountEndDate,
    this.status,
  });

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        provinceId.hashCode,
        areaId.hashCode,
        description.hashCode,
        locationDescription.hashCode,
        facebookUrl.hashCode,
        youtubeUrl.hashCode,
        instagramUrl.hashCode,
        telegramUrl.hashCode,
        teachingType.hashCode,
        outstandingTeaching.hashCode,
        teachingOnStudentHome.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeacherModel &&
            other.runtimeType == runtimeType &&
            other.hashCode == hashCode &&
            listEquals(other.stagesIds, stagesIds) == true &&
            listEquals(other.subjectsIds, subjectsIds) == true;
  }

  TeacherModel copyWithNewAccountData(Object teacherModel) {
    teacherModel as TeacherModel;
    return TeacherModel(
      id: id,
      name: teacherModel.name,
      phone: phone,
      imageUrl: imageUrl,
      description: teacherModel.description,
      locationDescription: teacherModel.locationDescription,
      stagesIds: teacherModel.stagesIds,
      provinces: provinces,
      allStages: allStages,
      provinceId: teacherModel.provinceId,
      areaId: teacherModel.areaId,
      facebookUrl: teacherModel.facebookUrl,
      youtubeUrl: teacherModel.youtubeUrl,
      instagramUrl: teacherModel.instagramUrl,
      telegramUrl: teacherModel.telegramUrl,
      teachingType: teacherModel.teachingType,
      outstandingTeaching: teacherModel.outstandingTeaching,
      teachingOnStudentHome: teacherModel.teachingOnStudentHome,
      discount: teacherModel.discount,
    );
  }

  factory TeacherModel.fromJson(Map<String, dynamic> data) =>
      _$TeacherModelFromJson(data);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  static Map<String, TeacherTeachingType> teacherTeachingTypesMap = {
    'الكل': TeacherTeachingType.ALL,
    'حضوري': TeacherTeachingType.ONSITE,
    'الكتروني': TeacherTeachingType.ONLINE,
  };

  static String getTeacherTeachingTypeKey(String val) {
    return teacherTeachingTypesMap.keys.firstWhere(
      (k) {
        print(k);
        return teacherTeachingTypesMap[k]?.name == val;
      },
      orElse: () => '',
    );
  }

  static String getTeacherTeachingTypeVal(String key) {
    return teacherTeachingTypesMap[key]?.name ??
        TeacherTeachingType.ONSITE.name;
  }
}
