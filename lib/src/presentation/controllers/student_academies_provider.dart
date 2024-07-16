import 'dart:async';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/data/student_repository.dart';
import 'package:education_app/src/presentation/controllers/pagination_controller.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/academy_model.dart';

class StudentAcademiesController
    extends AutoDisposeAsyncNotifier<List<AcademyModel>>
    implements PaginationController<AcademyModel, int> {
  @override
  FutureOr<List<AcademyModel>> build() async => await loadPage(currentPage);

  @override
  get initialPage => 1;

  @override
  int currentPage = 1;

  @override
  bool isLastPage = false;

  @override
  int get pageSize => 10;

  @override
  bool canLoadMore() {
    if (state.isLoading || state.hasError || isLastPage) {
      return false;
    } else {
      return true;
    }
  }

  @override
  FutureOr<List<AcademyModel>> loadPage(int page) async {
    await Future.delayed(const Duration(seconds: 1));

    final searchVal = ref.read(searchValProvider);

    final List<AcademyModel> items = await ref
        .read(studentRepositoryProvider)
        .getStudentTeachersOrAcademies(
          skip: currentPage,
          searchValue: searchVal,
          type: TeachingType.academy,
        );

    if (items.length < pageSize) {
      isLastPage = true;
    }

    return items;
  }

  @override
  Future<void> loadNextPage() async {
    final oldState = state;
    state = AsyncLoading<List<AcademyModel>>().copyWithPrevious(oldState);

    currentPage += 1;

    final searchVal = ref.read(searchValProvider);

    final newState = await AsyncValue.guard(
      () async {
        final items = await ref
            .read(studentRepositoryProvider)
            .getStudentTeachersOrAcademies<AcademyModel>(
              skip: currentPage,
              searchValue: searchVal,
              type: TeachingType.academy,
            );
        if (items.length < 10) {
          isLastPage = true;
        }
        return [...?state.value, ...items];
      },
    );
    if (newState.hasError) {
      final oldState = state;
      state = AsyncError<List<AcademyModel>>(
        newState.error!,
        newState.stackTrace!,
      ).copyWithPrevious(
        oldState,
      );
    } else {
      state = newState;
    }
  }

  @override
  Future<void> applyFiltersAndSearch() async {
    isLastPage = false;
    currentPage = 1;
    state = AsyncLoading<List<AcademyModel>>()
        .copyWithPrevious(const AsyncData([]));
    final newState = await AsyncValue.guard<List<AcademyModel>>(() async {
      return await loadPage(currentPage);
    });
    state = newState;
  }
}

final studentAcademiesControllerProvider = AsyncNotifierProvider.autoDispose<
    StudentAcademiesController, List<AcademyModel>>(
  () {
    return StudentAcademiesController();
  },
);
