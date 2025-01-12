import 'package:education_app/src/core/enum.dart';
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
    state = state.copyWith(provinceId: provinceId, clearArea: true);
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

  void updateSelectedTeachingType(TeacherTeachingType type) {
    state = state.copyWith(teachingType: type.name);
  }

  void updateSelectedTeachingPlace(TeachingPlace place) {
    state = state.copyWith(teachingPlace: place.name);
  }

  void updateSelectedCurriculum(CurriculumType type) {
    state = state.copyWith(curriculumType: type.name);
  }

  void updateByHighlightType(HighlightType type) {
    clearFilters();
    switch (type) {
      case HighlightType.online:
        state = state.copyWith(teachingType: TeacherTeachingType.ONLINE.name);
        break;
      case HighlightType.onsite:
        state = state.copyWith(teachingPlace: TeachingPlace.studentHome.name);
        break;
      case HighlightType.outstanding:
        state = state.copyWith(curriculumType: CurriculumType.outstanding.name);
        break;
      default:
        state = state.copyWith(discountsOnly: 1);
        break;
    }
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
