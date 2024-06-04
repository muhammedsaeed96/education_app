import 'dart:async';
import '../../model/current_filters_model.dart';

abstract class PaginationController<T, int> {
  bool isLastPage = false;

  int get pageSize;

  int get initialPage;

  late int currentPage = initialPage;

  FutureOr<List<T>> loadPage(int page);

  Future<void> loadNextPage();

  bool canLoadMore();

  Future<void> applyFiltersAndSearch();

  // int nextPage(int currentPage);
}
