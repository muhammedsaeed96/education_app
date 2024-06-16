import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/social_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AuthenticationModel {
  final String? name;
  final AccountType accountType;
  final String phone;
  final String? code;
  final String? description;
  final String? stageId;
  final String? provinceId;
  final String? areaId;
  final List subjectsIds;
  final List stagesIds;
  final String? locationDescription;
  final List<SocialModel> socials;

  AuthenticationModel({
    this.name,
    required this.accountType,
    required this.phone,
    this.code,
    this.description,
    this.stageId,
    this.provinceId,
    this.areaId,
    this.subjectsIds = const [],
    this.stagesIds = const [],
    this.locationDescription,
    this.socials = const [],
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> data) =>
      _$AuthenticationModelFromJson(data);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);

  AuthenticationModel copyWithOtp(String otp) {
    return AuthenticationModel(
      name: name,
      accountType: accountType,
      phone: phone,
      code: otp,
      locationDescription: locationDescription,
      areaId: areaId,
      stagesIds: stagesIds,
      subjectsIds: subjectsIds,
      description: description,
      stageId: stageId,
      provinceId: provinceId,
      socials: socials,
    );
  }

  AuthenticationModel copyWithPhoneAndAccountType({
    required String phone,
    required AccountType accountType,
  }) {
    return AuthenticationModel(
      name: name,
      accountType: accountType,
      phone: phone,
      code: code,
      locationDescription: locationDescription,
      areaId: areaId,
      stagesIds: stagesIds,
      subjectsIds: subjectsIds,
      description: description,
      stageId: stageId,
      provinceId: provinceId,
      socials: socials,
    );
  }
}


