import 'package:dio/dio.dart';
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

  Future<StudentModel> getStudentAccount({
    required String id,
    required String token,
  }) async {
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
    required String token,
  }) async {
    try {
      final res = await apiService.get(url: '${ApiUrls.getTeacherUrl}/$id');
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

  Future<AcademyModel> getAcademyAccount({
    required String id,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AcademyModel(
      visitorsNumber: 33,
      id: DateTime.now().toIso8601String(),
      title: 'معهد الامل',
      phone: '+9647717635164',
      description:
          'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء',
      locationDescription:
          'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء',
      socials: [],
    );
  }

  Future<void> updateStudentAccount({
    required StudentModel student,
    required String id,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> updateTeacherAccount({
    required TeacherModel teacher,
    required String id,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> updateAcademyAccount({
    required AcademyModel academy,
    required String id,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);
