import 'dart:io';

import 'package:dio/dio.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/api_services.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/api_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/errors/failures.dart';

class AccountRepository {
  final ApiService apiService;

  AccountRepository({required this.apiService});

  Future<StudentModel> getStudentAccount({required String id}) async {
    try {
      final res = await apiService.get(url: ApiUrls.studentUrl);
      final data = res.data[ApiKeys.dataKey];
      // set courses and seasons list to home model
      return StudentModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<TeacherModel> getTeacherAccount({
    required String id,
    required bool isPersonalAccount,
  }) async {

    final url = isPersonalAccount
        ? ApiUrls.getTeacherPersonalAccountUrl
        : '${ApiUrls.getTeacherUrl}/$id';

    try {
      final res = await apiService.get(url: url);
      final data = res.data[ApiKeys.dataKey];
      // set courses and seasons list to home model
      return TeacherModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<AcademyModel> getAcademyAccount({required String id}) async {
    try {
      final res = await apiService.get(url: '${ApiUrls.getAcademyUrl}/$id');
      final data = res.data[ApiKeys.dataKey];
      // set courses and seasons list to home model
      return AcademyModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<void> updateStudentAccount({
    required StudentModel student,
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> updateTeacherAccount({
    required TeacherModel teacher,
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> updateAcademyAccount({
    required AcademyModel academy,
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> uploadProfileImage({
    required File file,
    required AccountType accountType,
  }) async {
    try {
      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path, filename: fileName),
        'accountType': accountType.name,
      });

      final res = await apiService.patch(
        url: ApiUrls.uploadProfileImageUrl,
        body: formData,
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

  Future<void> deleteAccount({required AccountType accountType}) async {
    try {
      final res = await apiService.delete(
        url: '${ApiUrls.deleteAccountUrl}/${accountType.name}',
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

  Future<void> logout({required AccountType accountType}) async {
    try {
      final res = await apiService.delete(
        url: '${ApiUrls.logoutUrl}/${accountType.name}',
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
}

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);
