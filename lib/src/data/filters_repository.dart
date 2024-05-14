import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/filter_model.dart';

class FiltersRepository {
  // to get filters of teachers and academies from api
  Future<FilterModel> getFilters() async {
    // throw ('An error occur');
    await Future.delayed(const Duration(seconds: 1));
    return dummyFilters;
  }
}

final filterRepositoryProvider = Provider((ref) => FiltersRepository());
