class CurrentFiltersModel {
  final String? provinceId;
  final String? areaId;
  final String? stageId;
  final String? subjectId;

  CurrentFiltersModel({
    this.provinceId,
    this.areaId,
    this.stageId,
    this.subjectId,
  });

  CurrentFiltersModel copyWith({
    String? provinceId,
    String? areaId,
    String? stageId,
    String? subjectId,
    bool clearArea = false,
  }) {
    return CurrentFiltersModel(
      provinceId: provinceId ?? this.provinceId,
      areaId: clearArea ? null : areaId ?? this.areaId,
      stageId: stageId ?? this.stageId,
      subjectId: subjectId ?? this.subjectId,
    );
  }

  bool get hasValue {
    return provinceId != null ||
        areaId != null ||
        stageId != null ||
        subjectId != null;
  }
}
