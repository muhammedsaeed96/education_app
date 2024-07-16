import 'package:dio/dio.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/failures.dart';
import '../core/utils/api_services.dart';
import '../model/academy_model.dart';
import '../model/teacher_model.dart';

class TeachersRepository {
  final ApiService apiService;

  TeachersRepository({required this.apiService});

  Future<List<T>> getStudentTeachersOrAcademies<T>({
    String? searchValue,
    required int skip,
    required TeachingType type,
  }) async {
    try {

      final res = await apiService.get(
        url: type == TeachingType.teacher
            ? ApiUrls.getStudentsTeachers
            : ApiUrls.getStudentsAcademies,
        queryParameters: {
          AppKeys.skipKey: skip,
          AppKeys.takeKey: 10,
          AppKeys.nameKey: searchValue,
        },
      );

      final data = res.data[AppKeys.dataKey];
      return List<T>.from(
        data.map(
          (e) => type == TeachingType.teacher
              ? TeacherModel.fromJson(e)
              : AcademyModel.fromJson(e),
        ),
      );
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }
}

final studentRepositoryProvider = Provider.autoDispose<TeachersRepository>(
  (ref) => TeachersRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);
