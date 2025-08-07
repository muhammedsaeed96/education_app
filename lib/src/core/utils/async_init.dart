import 'package:education_app/src/core/utils/api_service.dart';
import 'package:education_app/src/core/utils/otp_helper.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class AsyncInit {
  final Ref _ref;

  late final LocalStorage localStorage;
  late final OtpHelper otpHelper;
  late final ApiService apiService;

  AsyncInit(this._ref);

  Future<void> init() async {
    localStorage = LocalStorage(await SharedPreferences.getInstance());
    apiService = ApiService(ref: _ref, localStorage: localStorage);
    otpHelper = OtpHelper(localStorage);
    if (localStorage.getUserInfo() != null) {
      _ref.read(isAuthenticationProvider.notifier).state = true;
    }
  }
}

final asyncInitProvider = Provider<AsyncInit>((ref) => AsyncInit(ref));
