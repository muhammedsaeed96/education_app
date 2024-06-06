import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_urls.dart';
import 'local_storage.dart';

class ApiService {
  static const _authorizationKey = 'Authorization';

  static late final Dio _dio;

  // to give me access to the all providers
  // final Ref ref;

  static LocalStorage? localStorage;

  void initializeDio() {
    _dio = _init();
  }

  Dio _init() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60), // 60 seconds
        receiveTimeout: const Duration(seconds: 60), // 60 seconds
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          await Future.delayed(const Duration(milliseconds: 250));
          final user = localStorage!.getUserInfo();
          // to get unique device id
          // Add the access token to the request header
          if (user != null) {
            options.headers[_authorizationKey] = "Bearer ${user.token}";
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          //print('onResponse');
          handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // final user = await localStorage.getUserInfo();

/*          if (e.response?.statusCode == 401 && user != null) {
*/ /*            // If a 401 response is received, refresh the access token
            String newAccessToken = await refreshToken();

            // Update the request header with the new access token
            e.requestOptions.headers[_authorizationKey] =
                'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));*/ /*
          }*/
          handler.next(e);
        },
      ),
    );
    return dio;
  }

/*  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<String> refreshToken() async {
    try {
      // Retrieve the refresh token from storage
      final user = await localStorage.getUserInfo();

      if (user?.refreshToken == null) {
        throw Exception("Refresh token not found.");
      }

      // Create a new Dio instance without interceptors
      final dio = Dio(BaseOptions(baseUrl: ApiUrls.baseUrl));

      dio.options.headers['Authorization'] = 'Bearer ${user?.refreshToken}';

      final res = await dio.post(ApiUrls.refreshTokenUrl);

      // to store after get new tokens
      await localStorage.storeUserInfo(
        user!.copyWith(
          accessToken: res.data['token_access'],
          refreshToken: res.data['token_refresh'],
        ),
      );

      return res.data['token_refresh'];
    } catch (error) {
      // Log the error for debugging
      debugPrint("Error refreshing token: $error");

      // if user logged in then i will execute logout
      if (ref.read(isAuthenticationProvider)) {
        ref.read(isAuthenticationProvider.notifier).state = false;
      }
      // Rethrow the error to be handled by the caller
      rethrow;
    }
  }*/

  Future<Response> post({
    required url,
    dynamic body,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.post(
      url,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  Future<Response> patch({
    required url,
    dynamic body,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.patch(
      url,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  Future<Response> get({
    required url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.get(
      url,
      data: body,
      queryParameters: queryParameters,
    );

    return response;
  }

  Future<Response> delete({
    required url,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.delete(
      url,
      queryParameters: queryParameters,
    );
    return response;
  }
}
