import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/common_widgets/error_message_widget.dart';
import 'package:education_app/src/common_widgets/loading.dart';
import 'package:education_app/src/common_widgets/retry_btn.dart';
import 'package:education_app/src/common_widgets/search_field.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/data/visitor_repository.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/presentation/controllers/student_teachers_provider.dart';
import 'package:education_app/src/presentation/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/teacher_academy_small_card.dart';
import '../../../../core/enum.dart';
import '../../../controllers/simple_state_controller.dart';

class TeachersView extends ConsumerWidget {
  const TeachersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
      child: Column(
        children: [
          const SearchField(
            hintTextStr: AppStrings.searchStr,
            type: SearchType.studentTeachers,
          ),
          Consumer(
            builder: (_, ref, child) {
              final state = ref.watch(studentTeachersControllerProvider);
              return Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.axisDirection ==
                            AxisDirection.down &&
                        scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent) {
                      final controller = ref.read(
                        studentTeachersControllerProvider.notifier,
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
    AsyncValue<List<TeacherModel>> state,
    WidgetRef ref,
  ) {
    final teachers = state.valueOrNull ?? [];
    final initialLoading = state.isLoading && teachers.isEmpty;
    final initialError = state.hasError && teachers.isEmpty;
    final loadingMore = state.isLoading && teachers.isNotEmpty;
    final loadingMoreError = state.hasError && teachers.isNotEmpty;

    final controller = ref.read(studentTeachersControllerProvider.notifier);
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
                    child: Loading(),
                  ),
                )
              ]
            : teachers.isEmpty
                ? [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: EmptyWidget(
                          text: searchText == null || searchText.isEmpty
                              ? AppStrings.notCommunicateWithAnyTeacherStr
                              : AppStrings.noResultStr,
                        ),
                      ),
                    ),
                  ]
                : [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(32),
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final teacher = teachers[index];
                            debugPrint(teacher.id);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TeacherAcademySmallCard(
                                title: teacher.name,
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
