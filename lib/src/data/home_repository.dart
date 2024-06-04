import 'package:dio/dio.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/api_keys.dart';
import '../core/constants/api_urls.dart';
import '../core/errors/failures.dart';
import '../core/utils/api_services.dart';
import '../model/main_model.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository({required this.apiService});

  Future<MainModel> getHomeData() async {
    try {
      final res = await apiService.get(url: ApiUrls.getHomeUrl);
      final data = res.data[ApiKeys.dataKey];
      // set courses and seasons list to home model
      return MainModel.fromJson(data);
    } catch (e) {
      var error = e.toString();
      if (e is DioException) {
        error = ServerFailure.fromDioError(e).message;
      }
      throw (error);
    }
  }
}

final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(
    apiService: ref.read(asyncInitProvider).apiService,
  ),
);


// to get home screen data from remote
final getHomeDataProvider = FutureProvider<MainModel>(
      (ref) => ref.read(homeRepositoryProvider).getHomeData(),
);
