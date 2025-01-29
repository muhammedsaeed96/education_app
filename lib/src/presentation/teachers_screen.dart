import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/common_widgets/error_message_widget.dart';
import 'package:education_app/src/common_widgets/loading.dart';
import 'package:education_app/src/common_widgets/retry_btn.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:education_app/src/data/visitor_repository.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/presentation/controllers/teacher_controller.dart';
import 'package:education_app/src/presentation/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/search_filter_row.dart';
import '../common_widgets/teacher_academy_small_card.dart';
import '../core/enum.dart';
import '../core/utils/async_init.dart';

class TeachersScreen extends ConsumerWidget {
  const TeachersScreen({super.key});

  static const routeName = '/teachers';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightType =
        ModalRoute.of(context)?.settings.arguments as HighlightType?;

    return Scaffold(
      appBar: AppBar(title: Text(highlightType.getTeachersScreenAppbarTitle)),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            SearchFilterRow(
              hintText: AppStrings.searchOnTeacherStr,
              type: SearchType.teacher,
            ),
            Consumer(
              builder: (_, ref, child) {
                final state = ref.watch(teacherControllerProvider);
                return Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.axisDirection ==
                              AxisDirection.down &&
                          scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent) {
                        final controller =
                            ref.read(teacherControllerProvider.notifier);
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
    AsyncValue<List<TeacherModel>> state,
    WidgetRef ref,
  ) {
    final teachers = state.valueOrNull ?? [];
    final initialLoading = state.isLoading && teachers.isEmpty;
    final initialError = state.hasError && teachers.isEmpty;
    final loadingMore = state.isLoading && teachers.isNotEmpty;
    final loadingMoreError = state.hasError && teachers.isNotEmpty;

    final controller = ref.read(teacherControllerProvider.notifier);
    // final searchText = ref.read(searchValProvider);
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
                    child: Loading(),
                  ),
                )
              ]
            : teachers.isEmpty
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
                      padding: EdgeInsets.symmetric(vertical: 32),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final teacher = teachers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TeacherAcademySmallCard(
                                title: teacher.name,
                                imageUrl: teacher.imageUrl,
                                city: teacher.province!.name,
                                region: teacher.area!.name,
                                discount: teacher.discount,
                                discountEndDate: teacher.discountEndDate,
                                press: () {
                                  final storage =
                                      ref.read(asyncInitProvider).localStorage;
                                  if (storage.getUserInfo()?.userId !=
                                      teacher.id) {
                                    ref
                                        .read(visitorRepositoryProvider)
                                        .createVisitors(
                                          id: teacher.id,
                                          type: TeachingType.teacher,
                                          increaseVisitorsNumber: true,
                                        );
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    TeacherDetailsScreen.routeName,
                                    arguments: teacher.id,
                                  );
                                },
                              ),
                            );
                          },
                          childCount: teachers.length,
                        ),
                      ),
                    ),
                    if (loadingMore)
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(child: Loading(size: 32)),
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
