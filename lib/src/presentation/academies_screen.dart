import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:education_app/src/presentation/controllers/academy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/empty_widget.dart';
import '../common_widgets/error_message_widget.dart';
import '../common_widgets/loading.dart';
import '../common_widgets/retry_btn.dart';
import '../common_widgets/teacher_academy_small_card.dart';
import '../common_widgets/search_filter_row.dart';
import '../data/visitor_repository.dart';
import 'controllers/simple_state_controller.dart';

class AcademiesScreen extends ConsumerWidget {
  const AcademiesScreen({super.key});

  static const routeName = '/academies';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.academiesStr)),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            const SearchFilterRow(
              hintText: AppStrings.searchOnAcademyStr,
              type: SearchType.academy,
            ),
            Consumer(
              builder: (_, ref, child) {
                final state = ref.watch(academyControllerProvider);
                return Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.axisDirection ==
                              AxisDirection.down &&
                          scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent) {
                        final controller =
                            ref.read(academyControllerProvider.notifier);
                        if (controller.canLoadMore()) {
                          controller.loadNextPage();
                        }
                      }
                      return true;
                    },
                    child: CustomScrollView(
                      slivers: [...repositories(context, state, ref)],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> repositories(
    BuildContext context,
    AsyncValue<List<AcademyModel>> state,
    WidgetRef ref,
  ) {
    final academies = state.valueOrNull ?? [];
    final initialLoading = state.isLoading && academies.isEmpty;
    final initialError = state.hasError && academies.isEmpty;
    final loadingMore = state.isLoading && academies.isNotEmpty;
    final loadingMoreError = state.hasError && academies.isNotEmpty;

    final controller = ref.read(academyControllerProvider.notifier);
    final searchText = ref.read(searchValProvider);

    return initialError
        ? [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 48),
                child: ErrorMessageWidget(
                  errorMessage: state.error.toString(),
                  retry: () => controller.applyFiltersAndSearch(),
                ),
              ),
            ),
          ]
        : initialLoading
            ? [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Loading(size : 124),
                  ),
                )
              ]
            : academies.isEmpty
                ? [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: EmptyWidget(text: AppStrings.noResultStr),
                      ),
                    ),
                  ]
                : [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: 32,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final academy = academies[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TeacherAcademySmallCard(
                                title: academy.title,
                                imageUrl: academy.imageUrl,
                                city: academy.province!.name,
                                region: academy.area!.name,
                                press: () {
                                  final storage =
                                      ref.read(asyncInitProvider).localStorage;
                                  if (storage.getUserInfo()?.userId !=
                                      academy.id) {
                                    ref
                                        .read(visitorRepositoryProvider)
                                        .createVisitors(
                                          id: academy.id,
                                          type: TeachingType.academy,
                                        );
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    AcademyDetailsScreen.routeName,
                                    arguments: academy.id,
                                  );
                                },
                              ),
                            );
                          },
                          childCount: academies.length,
                        ),
                      ),
                    ),
                    if (loadingMore)
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(child: Loading(size: 64)),
                      ),
                    if (loadingMoreError)
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        sliver: SliverToBoxAdapter(
                          child: RetryBtn(
                            press: () => controller.loadNextPage(),
                          ),
                        ),
                      ),
                  ];
  }
}
