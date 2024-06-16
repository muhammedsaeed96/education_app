import 'package:dio/dio.dart';

import 'constants/app_keys.dart';
import 'constants/app_strings.dart';

abstract class Failure {
  Failure(this.message);

  String message;
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  //to get error message from response data when an error occur
  static String _getErrorMessageFromResponse(Map<String, dynamic> data) {
    String errorMsg = AppStrings.unexpectedErrorStr;
    if (data.containsKey(AppKeys.messageKey)) {
      errorMsg = data[AppKeys.messageKey];
    }
    return errorMsg;
  }

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(AppStrings.unexpectedErrorStr);
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppStrings.unexpectedErrorStr);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(AppStrings.unexpectedErrorStr);
/*      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError);*/
      case DioExceptionType.cancel:
        return ServerFailure(AppStrings.unexpectedErrorStr);
      case DioExceptionType.connectionError:
        final message = dioError.message ?? '';
        if (message.contains('SocketException') ||
            message.contains('Network is unreachable')) {
          return ServerFailure(AppStrings.noInternetStr);
        }
        return ServerFailure(AppStrings.unexpectedErrorStr);
      default:
        return ServerFailure.fromResponse(dioError);
    }
  }

  factory ServerFailure.fromResponse(DioException error) {
    if (error.response?.data is Map) {
      //get the response status code
      // final statusCode = error.response?.statusCode ?? 0;
      //to get the error message from server
      final errorMsg = _getErrorMessageFromResponse(error.response?.data);
      return ServerFailure(errorMsg);
    } else {
      return ServerFailure(AppStrings.unexpectedErrorStr);
    }
  }
}

class GeneralFailure extends Failure {
  GeneralFailure(super.message);
}
