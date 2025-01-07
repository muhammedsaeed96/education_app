import 'dart:io';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'custom_file_converter.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StudentModel {
  final String id;
  final String name;
  final String phone;
  final String? imageUrl;
  @CustomFileConverter()
  final File? image;
  final String? provinceId;
  final String? stageId;
  final String? province;
  final String? stage;
  final List<StageModel> stages;
  final List<ProvinceModel> provinces;

  StudentModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.image,
    this.provinceId,
    this.stageId,
    this.province,
    this.stage,
    this.stages = const [],
    this.provinces = const [],
  });

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        provinceId?.hashCode,
        stageId?.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudentModel &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            stageId == other.stageId &&
            provinceId == other.provinceId;
  }

  StudentModel copyWithNewAccountData(Object studentModel) {
    studentModel as StudentModel;
    return StudentModel(
      id: id,
      name: studentModel.name,
      phone: phone,
      imageUrl: imageUrl,
      stageId: studentModel.stageId,
      provinceId: studentModel.provinceId,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> data) =>
      _$StudentModelFromJson(data);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
