import 'package:dio/dio.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/constants/app_strings.dart';
import '../core/failures.dart';
import '../core/utils/api_services.dart';
import '../model/visitor_model.dart';

class VisitorRepository {
  final ApiService apiService;

  VisitorRepository({required this.apiService});

  Future<void> createVisitors({
    required String id,
    required TeachingType type,
  }) async {
    final url =
        type == TeachingType.teacher ? ApiUrls.teacherUrl : ApiUrls.academyUrl;

    try {
      final res = await apiService.post(url: '$url/$id');
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

  Future<VisitorModel> getVisitors({required AccountType type}) async {
    final url = type == AccountType.TEACHER
        ? ApiUrls.getTeacherVisitorsUrl
        : ApiUrls.getAcademyVisitorsUrl;

    try {
      final res = await apiService.get(url: url);
      final data = res.data[AppKeys.dataKey];
      // set courses and seasons list to home model
      return VisitorModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }
}

final visitorRepositoryProvider = Provider((ref) {
  return VisitorRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  );
});

final getVisitorsProvider =
    FutureProvider.autoDispose.family<VisitorModel, AccountType>(
  (ref, type) {
    return ref.read(visitorRepositoryProvider).getVisitors(type: type);
  },
);
