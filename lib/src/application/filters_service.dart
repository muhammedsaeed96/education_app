import 'package:education_app/src/data/filters_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/filter_model.dart';

class FilterService {
  final FiltersRepository filtersRepository;

  FilterService({required this.filtersRepository});

  Future<FilterModel> getFilters() async {
    await filtersRepository.getFilters();
    return dummyFilters;
  }
}

final filtersServiceProvider = Provider(
  (ref) => FilterService(filtersRepository: ref.read(filterRepositoryProvider)),
);

final filtersProvider = FutureProvider(
  (ref) => ref.read(filtersServiceProvider).getFilters(),
);
