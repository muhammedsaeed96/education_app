import 'package:education_app/src/model/subject_model.dart';
import 'package:education_app/src/model/teacher_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'academy_model.dart';

part 'main_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MainModel {
  final List<SubjectModel> subjects;
  final List<TeacherModel> teachers;
  final List<AcademyModel> academies;

  MainModel({
    required this.subjects,
    required this.teachers,
    required this.academies,
  });

  factory MainModel.fromJson(Map<String, dynamic> data) => _$MainModelFromJson(data);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}

final dummyHomeData = MainModel(
  subjects: dummySubjects,
  teachers: dummyTeachers,
  academies: dummyAcademies,
);
