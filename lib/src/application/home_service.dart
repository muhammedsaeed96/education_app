import 'package:education_app/src/data/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/main_model.dart';

class HomeService {
  HomeService(this.homeRepository);

  final HomeRepository homeRepository;

  Future<MainModel> getHomeData() async {
    return await homeRepository.getHomeData();
  }
}

final homeServiceProvider = Provider(
  (ref) => HomeService(ref.read(homeRepositoryProvider)),
);

// to get home screen data from remote
final getHomeDataProvider = FutureProvider<MainModel>(
  (ref) => ref.read(homeServiceProvider).getHomeData(),
);
