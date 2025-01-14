import 'package:education_app/src/core/utils/api_service.dart';
import 'package:education_app/src/core/utils/otp_helper.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class AsyncInit {
  final Ref ref;

  late final SharedPreferences _sharedPreferences;
  late final LocalStorage localStorage;
  late final OtpHelper otpHelper;
  late final ApiService apiService;

  AsyncInit(this.ref) {
    _init();
  }

  Future<void> _init() async {
    apiService = ApiService(ref: ref);
    apiService.initializeDio();
    _sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage(_sharedPreferences);
    if(localStorage.getUserInfo() != null) {
      ref.read(isAuthenticationProvider.notifier).state = true;
    }
    otpHelper = OtpHelper(localStorage);
    ApiService.localStorage = localStorage;
  }
}

final asyncInitProvider = Provider<AsyncInit>((ref) => AsyncInit(ref));
