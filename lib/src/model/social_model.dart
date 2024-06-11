import 'package:education_app/src/core/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'social_model.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SocialModel{
  
  final String url;
  final LinkType type;


  SocialModel({required this.url,required this.type});

  factory SocialModel.fromJson(Map<String, dynamic> data) =>
      _$SocialModelFromJson(data);

  Map<String, dynamic> toJson() => _$SocialModelToJson(this);

}