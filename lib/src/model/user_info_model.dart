import 'package:education_app/src/core/enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_info_model.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: false)


class UserInfoModel {
  final String userId;
  final AccountType accountType;
  final String token;

  UserInfoModel({
    required this.userId,
    required this.accountType,
    required this.token,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> data) =>
      _$UserInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
