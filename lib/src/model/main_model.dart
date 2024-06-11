import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/model/update_info_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'academy_model.dart';

part 'main_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MainModel {
  final List<SubjectModel> subjects;
  final List<TeacherModel> teachers;
  final List<AcademyModel> academies;

  final List<ProvinceModel> provinces;
  @JsonKey(name: 'Areas')
  final List<AreaModel> areas;
  final List<StageModel> stages;
  final UpdateInfoModel updateInfo;

  MainModel({
    this.subjects = const [],
    this.teachers = const [],
    this.academies = const [],
    this.provinces = const [],
    this.areas = const [],
    this.stages = const [],
    required this.updateInfo,
  });

  factory MainModel.fromJson(Map<String, dynamic> data) =>
      _$MainModelFromJson(data);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}
