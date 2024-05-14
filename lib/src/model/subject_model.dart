import 'package:education_app/src/core/constants/assets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SubjectModel {
  final String id;
  final String title;
  final String? iconUrl;

  SubjectModel({
    required this.id,
    required this.title,
    this.iconUrl,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> data) =>
      _$SubjectModelFromJson(data);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}

final dummySubjects = [
  SubjectModel(id: 'abcd', title: 'الرياضيات', iconUrl: Assets.icMath),
  SubjectModel(id: 'bcde', title: 'الكيمياء', iconUrl: Assets.icChemistry),
  SubjectModel(id: 'fegr', title: 'الفيزياء', iconUrl: Assets.icPhysics),
  SubjectModel(id: 'ddfe', title: 'العربي', iconUrl: Assets.icArabic),
  SubjectModel(id: 'rtyu', title: 'الانكليزي', iconUrl: Assets.icEnglish),
];
