import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/academy_model.dart';

class AcademiesRepository {
  Future<AcademyModel> getAcademy(AcademyID id) async {
    await Future.delayed(const Duration(seconds: 1));
    return dummyAcademies.firstWhere((t) => t.id == id);
  }

  Future<List<AcademyModel>> getAcademies() async {
    await Future.delayed(const Duration(seconds: 1));
    return dummyAcademies;
  }
}

final academiesRepositoryProvider = Provider.autoDispose<AcademiesRepository>(
  (ref) => AcademiesRepository(),
);
