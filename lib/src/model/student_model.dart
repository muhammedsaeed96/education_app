import 'dart:io';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'area_model.dart';
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
  final String? areaId;
  final String? stageId;
  final List<ProvinceModel> provinces;
  final List<StageModel> stages;
  final String? province;
  final String? area;
  final String? stage;


  StudentModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.image,
    this.provinceId,
    this.areaId,
    this.provinces = const [],
    this.stageId,
    this.stages = const [],
    this.province,
    this.area,
    this.stage,
  });

  @override
  int get hashCode => Object.hash(
        name.hashCode,
         provinceId?.hashCode,
         areaId?.hashCode,
         stageId?.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudentModel &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }


  StudentModel copyWithNewAccountData(Object studentModel) {
    studentModel as StudentModel;
    return StudentModel(
      id: id,
      name: studentModel.name,
      phone: phone,
      imageUrl: imageUrl,
      provinces: provinces,
      stages: stages,
      stageId: studentModel.stageId,
      provinceId: studentModel.provinceId,
      areaId: studentModel.areaId,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> data) =>
      _$StudentModelFromJson(data);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
