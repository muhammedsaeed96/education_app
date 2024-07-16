import 'package:dio/dio.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_urls.dart';
import 'local_storage.dart';

class ApiService {
  static const _authorizationKey = 'Authorization';

  static late final Dio _dio;

  static LocalStorage? localStorage;

  final Ref _ref;

  ApiService({required Ref ref}) : _ref = ref;

  void initializeDio() {
    _dio = _init();
  }

  Dio _init() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 90), // 60 seconds
        receiveTimeout: const Duration(seconds: 90), // 60 seconds
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

          debugPrint(user?.token);

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
          // to clear user auth info and logout when his token not valid
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await localStorage?.removeUserInfo();
            _ref.read(isAuthenticationProvider.notifier).state = false;
          }
          handler.next(e);
        },
      ),
    );
    return dio;
  }

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
