import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_sizes.dart';
import 'init_easy_loading.dart';
import 'local_storage.dart';

class AsyncInit {

  late final SharedPreferences _sharedPreferences;
  late final LocalStorage localStorage;

  AsyncInit() {
    _init();
  }

  Future<void> _init() async {
    debugPrint('AsyncInit init');
    _sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage(_sharedPreferences);
  }
}

final asyncInitProvider = Provider<AsyncInit>((ref) => AsyncInit());
