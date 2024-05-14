import 'package:education_app/src/core/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AuthenticationModel {
  final AccountType accountType;
  final String phone;
  final String? otp;
  final String? description;
  final String? stage;
  final String? province;
  final String? area;
  final List<String> subjects;
  final List<String> stages;
  final String? locationDescription;

  AuthenticationModel({
    required this.accountType,
    required this.phone,
    this.otp,
    this.description,
    this.stage,
    this.province,
    this.area,
    this.subjects = const [],
    this.stages = const [],
    this.locationDescription,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> data) =>
      _$AuthenticationModelFromJson(data);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);

  AuthenticationModel copyWithOtp(String otp) {
    return AuthenticationModel(
      accountType: accountType,
      phone: phone,
      otp: otp,
      locationDescription: locationDescription,
      area: area,
      stages: stages,
      subjects: subjects,
      description: description,
      stage: stage,
      province: province,
    );
  }
}
