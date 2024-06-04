import 'package:education_app/src/core/utils/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class AsyncInit {

  late final SharedPreferences _sharedPreferences;
  late final LocalStorage localStorage;
  late final ApiService apiService;

  AsyncInit() {
    _init();
  }

  Future<void> _init() async {
    apiService = ApiService();
    apiService.initializeDio();
    debugPrint('AsyncInit init');
    _sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage(_sharedPreferences);
  }
}

final asyncInitProvider = Provider<AsyncInit>((ref) => AsyncInit());
