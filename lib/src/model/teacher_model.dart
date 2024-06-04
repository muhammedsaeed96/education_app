import 'dart:io';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/social_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'area_model.dart';
import 'custom_file_converter.dart';

part 'teacher_model.g.dart';

/// * The product identifier is an important concept and can have its own type.
typedef TeacherID = String;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TeacherModel {
  final String id;
  final String name;
  final String phone;
  final String? imageUrl;
  @CustomFileConverter()
  final File? image;
  final String description;
  final String locationDescription;
  @JsonKey(name: 'Subjects')
  final List<SubjectModel> subjects;
  final List<SocialModel> socials;

  @JsonKey(name: 'Province')
  final ProvinceModel? province;
  @JsonKey(name: 'Area')
  final AreaModel? area;
  @JsonKey(name: 'Stages')
  final List<StageModel> stages;
  @JsonKey(name: 'vistorsNumber')
  final int visitorsNumber;

  TeacherModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.image,
    required this.description,
    this.province,
    this.area,
    required this.locationDescription,
    this.subjects = const [],
    this.stages = const [],
    required this.visitorsNumber,
    this.socials = const [],
  });

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        province.hashCode,
        description.hashCode,
        area.hashCode,
        locationDescription.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeacherModel &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }

  factory TeacherModel.fromJson(Map<String, dynamic> data) =>
      _$TeacherModelFromJson(data);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}

final dummyTeachers = [
  TeacherModel(
    visitorsNumber: 44,
    id: '1234',
    name: 'محمد سعيد',
    phone: '9647717635164',
    imageUrl:
        'https://www.clickvieweducation.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fteacher-1.48b5788a.png&w=1080&q=80',
    description: 'هناك حقيقة مثبتة',
    // province: 'بغداد',
    // area: 'الغزالية',
    locationDescription: 'locationDescription',
    socials: [],
    // subjects: ['الرياضيات'],
    // stages: [
    //   'متوسطة',
    //   'الاعدادية',
    // ],
  ),
/*  TeacherModel(
    id: '12345',
    name: 'ياسر جلال',
    phone: '9647717635164',
    imageUrl:
        'https://img.lovepik.com/free-png/20210919/lovepik-male-teacher-teaching-png-image_400770642_wh1200.png',
    description:
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
    province: 'بغداد',
    area: 'البنوك',
    locationDescription: 'locationDescription',
    subjects: ['الرياضيات'],
    stages: [
      'متوسطة',
      'الاعدادية',
    ],
  ),
  TeacherModel(
    id: '123456',
    name: 'ياسر جلال',
    phone: '9647717635164',
    description:
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
    province: 'بغداد',
    area: 'حي الجامعة',
    locationDescription: 'locationDescription',
    subjects: ['الرياضيات'],
    stages: [
      'متوسطة',
      'الاعدادية',
    ],
  ),*/
];
