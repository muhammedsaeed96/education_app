import 'package:education_app/src/core/enum.dart';

class CurrentFiltersModel {
  final String? provinceId;
  final String? areaId;
  final String? stageId;
  final String? subjectId;
  final String teachingType; // all , online , onsite
  final String curriculumType;
  final String teachingPlace;
  final int? discountsOnly;

  CurrentFiltersModel({
    this.provinceId,
    this.areaId,
    this.stageId,
    this.subjectId,
    this.teachingType = 'ALL',
    this.curriculumType = 'all',
    this.teachingPlace = 'all',
    this.discountsOnly,
  });

  CurrentFiltersModel copyWith({
    String? provinceId,
    String? areaId,
    String? stageId,
    String? subjectId,
    String? teachingType,
    String? curriculumType,
    String? teachingPlace,
    int? discountsOnly,
    bool clearArea = false,
  }) {
    return CurrentFiltersModel(
      provinceId: provinceId ?? this.provinceId,
      areaId: clearArea ? null : areaId ?? this.areaId,
      stageId: stageId ?? this.stageId,
      subjectId: subjectId ?? this.subjectId,
      teachingType: teachingType ?? this.teachingType,
      curriculumType: curriculumType ?? this.curriculumType,
      teachingPlace: teachingPlace ?? this.teachingPlace,
      discountsOnly: discountsOnly ?? this.discountsOnly,
    );
  }

  bool get hasValue {
    return provinceId != null ||
        areaId != null ||
        stageId != null ||
        subjectId != null;
  }

  int? get isOutstandingTeaching {
    if (curriculumType == CurriculumType.outstanding.name) {
      return 1;
    }
    if (curriculumType == CurriculumType.ordinary.name) {
      return 0;
    }
  }

  int? get isTeachingOnStudentHome {
    if (teachingPlace == TeachingPlace.studentHome.name) {
      return 1;
    }
    if (teachingPlace == TeachingPlace.teacherLocation.name) {
      return 0;
    }
  }

  String? get getTeachingType {
    if (teachingType == TeacherTeachingType.ALL.name) {
      return null;
    }

    return teachingType;
  }
}
