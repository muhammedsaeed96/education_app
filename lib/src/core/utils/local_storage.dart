import 'dart:convert';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_keys.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage(this.sharedPreferences);

  Future<void> storeUserInfo(UserInfoModel userInfo) async {
    await sharedPreferences.setString(
      AppKeys.userInfoKey,
      json.encode(userInfo.toJson()),
    );
  }

  UserInfoModel? getUserInfo() {
    final val = sharedPreferences.getString(AppKeys.userInfoKey);
    if (val != null) {
      return UserInfoModel.fromJson(json.decode(val));
    }
    return null;
  }

  bool get isAuth => getUserInfo() != null;

  bool isNotStudent() {
    final user = getUserInfo();
    if (user?.accountType != AccountType.STUDENT) {
      return true;
    }
    return false;
  }

  bool isTeacher() {
    final user = getUserInfo();
    if (user?.accountType == AccountType.TEACHER) {
      return true;
    }
    return false;
  }

  Future<void> removeUserInfo() async {
    await sharedPreferences.remove(AppKeys.userInfoKey);
  }

  Future setNextOtpAttempt(String time) async {
    await sharedPreferences.setString(AppKeys.nextOtpPermittedTimeKey, time);
  }

  String? get getNextOtpAttempt {
    return sharedPreferences.getString(AppKeys.nextOtpPermittedTimeKey);
  }

  Future setOtpReqTimes(int num) async {
    await sharedPreferences.setInt(AppKeys.otpRequestTimesKey, num.toInt());
  }

  int get getOtpReqTimes {
    return sharedPreferences.getInt(AppKeys.otpRequestTimesKey) ?? 0;
  }

}
