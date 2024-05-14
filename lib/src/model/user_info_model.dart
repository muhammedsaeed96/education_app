import 'dart:convert';

class UserInfoModel {
  final String id;
  final String accountType;
  final String token;

  UserInfoModel({
    required this.id,
    required this.accountType,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'accountType': accountType,
        'token': token,
      };

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        accountType = json['accountType'] as String,
        token = json['token'] as String;
}
