import 'package:dio/dio.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/app_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/failures.dart';
import '../core/utils/api_services.dart';

class GeneralRepository {
  final ApiService apiService;

  GeneralRepository({required this.apiService});

  Future<AppInfoModel> getContactInfo() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final res = await apiService.get(url: ApiUrls.getContactInfoUrl);
      final data = res.data[AppKeys.dataKey];
      // set courses and seasons list to home model
      return AppInfoModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }

  Future<String> getAboutAsText() async {
    try {
      final res = await apiService.get(url: ApiUrls.getAboutUsUrl);
      final data = res.data[AppKeys.dataKey];
      // set courses and seasons list to home model
      return data['info'];
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }
}

final generalRepositoryProvider = Provider(
  (ref) => GeneralRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);

final getContactInfoProvider = FutureProvider<AppInfoModel>(
  (ref) => ref.read(generalRepositoryProvider).getContactInfo(),
);


final getAboutAsProvider = FutureProvider<String>(
      (ref) => ref.read(generalRepositoryProvider).getAboutAsText(),
);