import 'package:education_app/src/model/current_filters_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentFiltersProvider = StateProvider<CurrentFiltersModel>(
  (ref) => CurrentFiltersModel(),
);
