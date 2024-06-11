import 'dart:io';
import 'package:education_app/src/model/update_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdater {
  Future<String> _getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  //v1 must local version or current app version
  //v2 must be current app version or remote version
  //if v1 less than v2 it mean new version available
  bool _isNewVersion(String v1, String v2) {
    final List<String> separatedV1 = v1.split('.');
    final List<String> separatedV2 = v2.split('.');

    final List<int> intSeparatedV1 = _convertStringListToIntList(separatedV1);
    final List<int> intSeparatedV2 = _convertStringListToIntList(separatedV2);

    if (intSeparatedV1[0] < intSeparatedV2[0] ||
        intSeparatedV1[1] < intSeparatedV2[1] ||
        intSeparatedV1[2] < intSeparatedV2[2]) {
      return true;
    } else {
      return false;
    }
  }

  List<int> _convertStringListToIntList(List<String> items) {
    return items.map((e) => int.parse(e)).toList();
  }

  Future<bool> showUpdateDialog(UpdateInfoModel updateInfo) async {
    final appVersionCode = await _getAppVersionCode();
    //is update available to current platform (ios or android)
    final versionName =
        Platform.isAndroid ? updateInfo.versionAndroid : updateInfo.versionIos;
    debugPrint(versionName);
    return _isNewVersion(appVersionCode, versionName);
  }
}
