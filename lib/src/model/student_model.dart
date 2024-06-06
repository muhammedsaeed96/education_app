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
  @JsonKey(name: 'Province')
  final ProvinceModel province;
  @JsonKey(name: 'Area')
  final AreaModel area;
  @JsonKey(name: 'Stage')
  final StageModel stage;

  StudentModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.image,
    required this.province,
    required this.area,
    required this.stage,
  });

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        // city.hashCode,
        // region.hashCode,
        stage.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StudentModel &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }

  factory StudentModel.fromJson(Map<String, dynamic> data) =>
      _$StudentModelFromJson(data);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
