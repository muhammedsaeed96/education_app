import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher_model.g.dart';

/// * The product identifier is an important concept and can have its own type.
typedef TeacherID = String;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TeacherModel {
  final String id;
  final String name;
  final String phone;
  final String? imageUrl;
  final String description;
  final String city;
  final String region;
  final String locationDescription;
  final List<StageModel> stages;
  final List<SubjectModel> subjects;

  TeacherModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    required this.description,
    required this.city,
    required this.region,
    required this.locationDescription,
    this.subjects = const [],
    this.stages = const [],
  });

  factory TeacherModel.fromJson(Map<String, dynamic> data) =>
      _$TeacherModelFromJson(data);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}

final dummyTeachers = [
  TeacherModel(
    id: '1234',
    name: 'محمد سعيد',
    phone: '9647717635164',
    imageUrl:
        'https://www.clickvieweducation.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fteacher-1.48b5788a.png&w=1080&q=80',
    description: 'هناك حقيقة مثبتة',
    city: 'بغداد',
    region: 'الغزالية',
    locationDescription: 'locationDescription',
    subjects: [SubjectModel(id: '123', title: 'الرياضيات')],
    stages: [
      StageModel(id: '123', title: 'متوسطة'),
      StageModel(id: '222', title: 'الاعدادية')
    ],
  ),
  TeacherModel(
    id: '12345',
    name: 'ياسر جلال',
    phone: '9647717635164',
    imageUrl:
        'https://img.lovepik.com/free-png/20210919/lovepik-male-teacher-teaching-png-image_400770642_wh1200.png',
    description:
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
    city: 'بغداد',
    region: 'البنوك',
    locationDescription: 'locationDescription',
    subjects: [SubjectModel(id: '123', title: 'الرياضيات')],
    stages: [
      StageModel(id: '123', title: 'متوسطة'),
      StageModel(id: '222', title: 'اعدادية')
    ],
  ),
  TeacherModel(
    id: '123456',
    name: 'ياسر جلال',
    phone: '9647717635164',
    description:
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
    city: 'بغداد',
    region: 'حي الجامعة',
    locationDescription: 'locationDescription',
    subjects: [SubjectModel(id: '123', title: 'الرياضيات')],
    stages: [
      StageModel(id: '123', title: 'متوسطة'),
      StageModel(id: '222', title: 'اعدادية')
    ],
  ),
];
