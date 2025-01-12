import 'package:dio/dio.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/current_filters_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/failures.dart';
import '../core/utils/api_services.dart';
import '../model/teacher_model.dart';

class TeachersRepository {
  final ApiService apiService;

  TeachersRepository({required this.apiService});

  Future<List<TeacherModel>> getTeachers({
    CurrentFiltersModel? filters,
    String? searchValue,
    required int skip,
  }) async {
    try {
      final res = await apiService.get(
        url: ApiUrls.teacherUrl,
        queryParameters: {
          AppKeys.provinceIdKey: filters?.provinceId,
          AppKeys.areaIdKey: filters?.areaId,
          AppKeys.stageIdKey: filters?.stageId,
          AppKeys.subjectIdKey: filters?.subjectId,
          AppKeys.outstandingTeachingKey: filters?.isOutstandingTeaching,
          AppKeys.teachingOnStudentHomeKey: filters?.isTeachingOnStudentHome,
          AppKeys.teachingTypeKey: filters?.getTeachingType,
          AppKeys.discountsOnlyKey: filters?.discountsOnly,
          AppKeys.skipKey: skip,
          AppKeys.takeKey: 10,
          AppKeys.nameKey: searchValue,
        },
      );
      final data = res.data[AppKeys.dataKey];
      // set courses and seasons list to home model
      return List<TeacherModel>.from(
        data.map((e) => TeacherModel.fromJson(e)),
      );
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<TeacherModel> getTeacher(TeacherID id) async {
    try {
      final res = await apiService.get(url: '${ApiUrls.teacherUrl}/$id');
      final data = res.data[AppKeys.dataKey];
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
}

final teacherRepositoryProvider = Provider.autoDispose<TeachersRepository>(
  (ref) => TeachersRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);

final getTeacherByIdProvider =
    FutureProvider.autoDispose.family<TeacherModel, TeacherID>(
  (ref, id) => ref.read(teacherRepositoryProvider).getTeacher(id),
);
