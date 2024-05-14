import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/local_storage.dart';
import 'package:education_app/src/model/authentication_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final LocalStorage localStorage;

  AuthenticationRepository(this.localStorage);

  Future<void> requestOtpForSignIn(
      {required String phone, required String accountType}) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint(phone);
    // throw ('An Error occur');
  }

  Future<void> requestOtpForSignup(
      {required String phone, required String accountType}) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint(phone);
    // throw ('An Error occur');
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
    required String accountType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    await localStorage.storeUserInfo(
      UserInfoModel(
        id: DateTime.now().toIso8601String(),
        accountType: accountType,
        token: DateTime.now().toIso8601String(),
      ),
    );
    // throw ('An Error occur');
  }

  Future<void> createUserAccount(AuthenticationModel authentication) async {
    await Future.delayed(const Duration(seconds: 1));
    await localStorage.storeUserInfo(
      UserInfoModel(
        id: DateTime.now().toIso8601String(),
        accountType: authentication.accountType.name,
        token: DateTime.now().toIso8601String(),
      ),
    );
    // throw ('An Error occur');
  }
}

final authenticationRepositoryProvider =
    Provider.autoDispose<AuthenticationRepository>(
  (ref) => AuthenticationRepository(
    ref.read(asyncInitProvider).localStorage,
  ),
);
