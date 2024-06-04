import 'package:json_annotation/json_annotation.dart';

part 'stage_model.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StageModel{
  final String id;
  final String name;


  StageModel({required this.id , required this.name});

  factory StageModel.fromJson(Map<String, dynamic> data) =>
      _$StageModelFromJson(data);

  Map<String, dynamic> toJson() => _$StageModelToJson(this);

}