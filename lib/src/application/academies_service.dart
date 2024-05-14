import 'package:education_app/src/data/academies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/academy_model.dart';

class AcademiesService {
  final AcademiesRepository academiesRepository;

  AcademiesService(this.academiesRepository);

  Future<AcademyModel> getAcademy(AcademyID id) async {
    return await academiesRepository.getAcademy(id);
  }

  Future<List<AcademyModel>> getAcademies() async {
    return await academiesRepository.getAcademies();
  }
}

final academyServiceProvider = Provider.autoDispose<AcademiesService>(
  (ref) => AcademiesService(ref.read(academiesRepositoryProvider)),
);

final getAcademyByIdProvider =
    FutureProvider.autoDispose.family<AcademyModel, AcademyID>(
  (ref, id) => ref.read(academyServiceProvider).getAcademy(id),
);

final getAcademiesProvider = FutureProvider.autoDispose<List<AcademyModel>>(
  (ref) => ref.read(academyServiceProvider).getAcademies(),
);
