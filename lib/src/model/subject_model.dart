import 'package:education_app/src/core/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SubjectModel {
  final String id;
  final String name;
  @JsonKey(name: 'imageUrl')
  final String? iconUrl;

  SubjectModel({
    required this.id,
    required this.name,
    this.iconUrl,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> data) =>
      _$SubjectModelFromJson(data);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
