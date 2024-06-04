import 'package:education_app/src/model/current_filters_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/home_repository.dart';
import '../../model/area_model.dart';

class FiltersController extends Notifier<CurrentFiltersModel> {
  @override
  CurrentFiltersModel build() {
    return CurrentFiltersModel();
  }

  void updateSelectedProvince(String provinceId) {
    state = state.copyWith(provinceId: provinceId);
  }

  void updateSelectedArea(String areaId) {
    state = state.copyWith(areaId: areaId);
  }

  void updateSelectedStage(String stageId) {
    state = state.copyWith(stageId: stageId);
  }

  void updateSelectedSubject(String subjectId) {
    state = state.copyWith(subjectId: subjectId);
  }

  List<AreaModel> getAreasByProvinceId() {
    if (state.provinceId == null) {
      return [];
    }
    final provinces = ref.read(getHomeDataProvider).value!.provinces;
    final areas = provinces.firstWhere((p) => p.id == state.provinceId).areas;
    return areas;
  }



  void clearFilters() {
    state = CurrentFiltersModel();
  }
}

final filtersControllerProvider =
    NotifierProvider<FiltersController, CurrentFiltersModel>(
  () {
    return FiltersController();
  },
);
