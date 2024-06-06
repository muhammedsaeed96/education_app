import 'package:education_app/src/core/utils/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class AsyncInit {

  final Ref ref;

  late final SharedPreferences _sharedPreferences;
  late final LocalStorage localStorage;
  late final ApiService apiService;

  AsyncInit(this.ref) {
    _init();
  }

  Future<void> _init() async {
    apiService = ApiService();
    apiService.initializeDio();
    _sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage(_sharedPreferences);
    ApiService.localStorage = localStorage;
    debugPrint('AsyncInit init');
  }
}

final asyncInitProvider = Provider<AsyncInit>((ref) => AsyncInit(ref));
