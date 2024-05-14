import 'package:education_app/src/model/stage_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'academy_model.g.dart';

typedef AcademyID = String;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AcademyModel {
  final String id;
  final String title;
  final String phone;
  final String? imageUrl;
  final String description;
  final String city;
  final String region;
  final String locationDescription;
  final List<StageModel> stages;

  AcademyModel({
    required this.id,
    required this.title,
    required this.phone,
    this.imageUrl,
    required this.description,
    required this.city,
    required this.region,
    required this.locationDescription,
    this.stages = const [],
  });

  factory AcademyModel.fromJson(Map<String, dynamic> data) =>
      _$AcademyModelFromJson(data);

  Map<String, dynamic> toJson() => _$AcademyModelToJson(this);
}

final dummyAcademies = [
  AcademyModel(
      id: '1234',
      title: 'معهد الامل',
      phone: '9647717635164',
      imageUrl:
          'https://pbs.twimg.com/profile_images/1659200757902770178/tSmJnBSk.jpg',
      description: 'هناك حقيقة مثبتة',
      city: 'بغداد',
      region: 'الغزالية',
      locationDescription: 'locationDescription',
      stages: [StageModel(id: '123', title: 'متوسطة')]),
  AcademyModel(
      id: '123412',
      title: 'معهد النجاج',
      phone: '9647717635164',
      imageUrl:
          'https://pbs.twimg.com/profile_images/1535318998035857408/N1U4pwpJ_400x400.jpg',
      description: 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
      city: 'بغداد',
      region: 'المنصور',
      locationDescription: 'locationDescription',
      stages: [StageModel(id: '123', title: 'متوسطة')]),
];
