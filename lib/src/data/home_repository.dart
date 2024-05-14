import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/main_model.dart';

class HomeRepository{

  Future<MainModel> getHomeData()async{
  await  Future.delayed(const Duration(milliseconds: 500));
  return dummyHomeData;
  }

}

final homeRepositoryProvider = Provider((ref) => HomeRepository());
