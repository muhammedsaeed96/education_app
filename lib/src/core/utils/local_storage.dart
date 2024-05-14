import 'dart:convert';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/keys.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage(this.sharedPreferences);

  Future<void> storeUserInfo(UserInfoModel userInfo) async {
    await sharedPreferences.setString(
      userInfoKey,
      json.encode(userInfo.toJson()),
    );
  }

  UserInfoModel? getUserInfo() {
    final val = sharedPreferences.getString(userInfoKey);
    if (val != null) {
      return UserInfoModel.fromJson(json.decode(val));
    }
    return null;
  }

  Future<void> removeUserInfo() async =>
      await sharedPreferences.remove(userInfoKey);
}
