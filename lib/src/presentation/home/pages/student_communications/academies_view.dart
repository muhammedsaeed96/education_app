import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/common_widgets/error_message_widget.dart';
import 'package:education_app/src/common_widgets/loading.dart';
import 'package:education_app/src/common_widgets/retry_btn.dart';
import 'package:education_app/src/common_widgets/search_field.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/data/visitor_repository.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/teacher_academy_small_card.dart';
import '../../../../core/enum.dart';
import '../../../controllers/simple_state_controller.dart';
import '../../../controllers/student_academies_provider.dart';

class AcademiesView extends ConsumerWidget {
  const AcademiesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
      child: Column(
        children: [
          const SearchField(
            hintTextStr: AppStrings.searchStr,
            type: SearchType.studentAcademies,
          ),
          Consumer(
            builder: (_, ref, child) {
              final state = ref.watch(studentAcademiesControllerProvider);
              return Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.axisDirection ==
                            AxisDirection.down &&
                        scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent) {
                      final controller = ref.read(
                        studentAcademiesControllerProvider.notifier,
                      );
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

    final controller = ref.read(studentAcademiesControllerProvider.notifier);
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
                        child: EmptyWidget(
                          text: searchText == null || searchText.isEmpty
                              ? AppStrings.notCommunicateWithAnyAcademyStr
                              : AppStrings.noResultStr,
                        ),
                      ),
                    ),
                  ]
                : [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final teacher = academies[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TeacherAcademySmallCard(
                                title: teacher.title,
                                imageUrl: teacher.imageUrl,
                                city: teacher.province!.name,
                                region: teacher.area!.name,
                                press: () {
                                  // to add visitor to teacher
                                  ref
                                      .read(visitorRepositoryProvider)
                                      .createVisitors(
                                        id: teacher.id,
                                        type: TeachingType.teacher,
                                      );
                                  Navigator.pushNamed(
                                    context,
                                    AcademyDetailsScreen.routeName,
                                    arguments: teacher.id,
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
