import 'package:dio/dio.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/authentication_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/failures.dart';

class AuthenticationRepository {
  final Ref ref;

  AuthenticationRepository(this.ref);

  Future<void> requestOtpForSignIn({
    required String phone,
    required String accountType,
  }) async {
    try {
      final res = await ref.read(asyncInitProvider).apiService.post(
        url: ApiUrls.requestOtpForSignInUrl,
        body: {
          AppKeys.phoneKey: phone,
          AppKeys.accountTypeKey: accountType,
        },
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        throw (AppStrings.unexpectedErrorStr);
      }
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<void> requestOtpForSignup({
    required String phone,
    required String accountType,
  }) async {
    try {
      debugPrint("requestOtpForSignup 444");

      final res = await ref.read(asyncInitProvider).apiService.post(
        url: ApiUrls.requestOtpForSignupUrl,
        body: {
          AppKeys.phoneKey: phone,
          AppKeys.accountTypeKey: accountType,
        },
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        throw (AppStrings.unexpectedErrorStr);
      }
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<UserInfoModel> verifyOtp({
    required String phone,
    required String otp,
    required String accountType,
  }) async {
    try {
      final res = await ref.read(asyncInitProvider).apiService.post(
        url: ApiUrls.verifyOtpUrl,
        body: {
          AppKeys.phoneKey: phone,
          AppKeys.accountTypeKey: accountType,
          AppKeys.codeKey: otp,
        },
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        throw (AppStrings.unexpectedErrorStr);
      }

      return UserInfoModel.fromJson(res.data['data']);

    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<UserInfoModel> createUserAccount({
    required AuthenticationModel authentication,
    required requestUrl,
  }) async {
    try {
      final res = await ref.read(asyncInitProvider).apiService.post(
            url: requestUrl,
            body: authentication.toJson(),
          );
      if (res.statusCode != 200 && res.statusCode != 201) {
        throw (AppStrings.unexpectedErrorStr);
      }
      return UserInfoModel.fromJson(res.data['data']);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }
}

final authenticationRepositoryProvider =
    Provider.autoDispose<AuthenticationRepository>(
  (ref) => AuthenticationRepository(ref),
);
