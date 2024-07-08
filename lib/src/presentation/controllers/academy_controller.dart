import 'dart:async';
import 'package:education_app/src/data/academey_repository.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/controllers/pagination_controller.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcademyController extends AutoDisposeAsyncNotifier<List<AcademyModel>>
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
    final filters = ref.read(filtersControllerProvider);

    final items = await ref.read(academiesRepositoryProvider).getAcademies(
          skip: currentPage,
          filters: filters,
          searchValue: searchVal,
        );

    if (items.length < pageSize) {
      isLastPage = true;
    }

    return items;
  }

  @override
  Future<void> loadNextPage() async {
    final oldState = state;
    state = const AsyncLoading<List<AcademyModel>>().copyWithPrevious(oldState);
    currentPage += 1;

    final searchVal = ref.read(searchValProvider);
    final filters = ref.read(filtersControllerProvider);

    final newState = await AsyncValue.guard(
      () async {
        final items = await ref.read(academiesRepositoryProvider).getAcademies(
              skip: currentPage,
              searchValue: searchVal,
              filters: filters,
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
    state = const AsyncLoading<List<AcademyModel>>().copyWithPrevious(
      const AsyncData([]),
    );
    final newState = await AsyncValue.guard<List<AcademyModel>>(() async {
      return await loadPage(currentPage);
    });
    state = newState;
  }
}

final academyControllerProvider =
    AsyncNotifierProvider.autoDispose<AcademyController, List<AcademyModel>>(
  () => AcademyController(),
);
