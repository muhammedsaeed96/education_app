import 'dart:io';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/custom_file_converter.dart';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/social_model.dart';
import 'package:education_app/src/model/stage_model.dart';
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
  @JsonKey(name: 'vistorsNumber')
  final int visitorsNumber;
  final List<SocialModel> socials;

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
    required this.visitorsNumber,
    this.socials = const [],
  });

  @override
  int get hashCode => Object.hash(
        title.hashCode,
        province.hashCode,
        area.hashCode,
        description.hashCode,
        locationDescription.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AcademyModel &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }

  factory AcademyModel.fromJson(Map<String, dynamic> data) =>
      _$AcademyModelFromJson(data);

  Map<String, dynamic> toJson() => _$AcademyModelToJson(this);
}
