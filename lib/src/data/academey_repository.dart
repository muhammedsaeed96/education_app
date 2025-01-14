import 'package:dio/dio.dart';
import 'package:education_app/src/core/utils/api_service.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/failures.dart';
import '../model/academy_model.dart';
import '../model/current_filters_model.dart';

class AcademyRepository {
  final ApiService apiService;

  AcademyRepository({required this.apiService});

  Future<AcademyModel> getAcademy(AcademyID id) async {
    try {
      final res = await apiService.get(url: '${ApiUrls.academyUrl}/$id');
      final data = res.data[AppKeys.dataKey];
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

  Future<List<AcademyModel>> getAcademies({
    CurrentFiltersModel? filters,
    String? searchValue,
    required int skip,
  }) async {
    try {
      final res = await apiService.get(
        url: ApiUrls.academyUrl,
        queryParameters: {
          AppKeys.provinceIdKey: filters?.provinceId,
          AppKeys.areaIdKey: filters?.areaId,
          AppKeys.stageIdKey: filters?.stageId,
/*          AppKeys.teachingTypeKey: filters?.getTeachingType,
          AppKeys.outstandingTeachingKey: filters?.isOutstandingTeaching,
          AppKeys.teachingOnStudentHomeKey: filters?.isTeachingOnStudentHome,
          AppKeys.discountsOnlyKey: filters?.discountsOnly,*/
          AppKeys.skipKey: skip,
          AppKeys.takeKey: 10,
          AppKeys.nameKey: searchValue,
        },
      );
      final data = res.data[AppKeys.dataKey];
      // set courses and seasons list to home model
      return List<AcademyModel>.from(
        data.map((e) => AcademyModel.fromJson(e)),
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

final academiesRepositoryProvider = Provider.autoDispose<AcademyRepository>(
  (ref) => AcademyRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);

final getAcademyByIdProvider =
    FutureProvider.autoDispose.family<AcademyModel, AcademyID>(
  (ref, id) => ref.read(academiesRepositoryProvider).getAcademy(id),
);
