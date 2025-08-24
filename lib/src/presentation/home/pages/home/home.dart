import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/title_btn_widget.dart';
import 'package:education_app/src/common_widgets/title_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:education_app/src/presentation/home/pages/home/academies_horizontal_list.dart';
import 'package:education_app/src/presentation/home/pages/home/highlights_grid.dart';
import 'package:education_app/src/presentation/home/pages/home/subjects_horizontal_card.dart';
import 'package:education_app/src/presentation/home/pages/home/teachers_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../data/home_repository.dart';
import '../../../../model/teacher_model.dart';
import '../../../academies_screen.dart';
import '../../../controllers/filter_controller.dart';
import '../../../controllers/simple_state_controller.dart';
import '../../../teachers_screen.dart';
import 'advertisements_slider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final value = ref.watch(getHomeDataProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getHomeDataProvider);
      },
      child: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getHomeDataProvider),
        loading: AdvanceLoading(),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              if (data.advertisements.isNotEmpty) ...[
                AdvertisementsSlider(advertisements: data.advertisements),
                gap24,
              ],
              const Padding(
                padding: paddingH24,
                child: TitleWidget(title: AppStrings.subjectsStr),
              ),
              gap12,
              SubjectsHorizontalList(subjects: data.subjects),
              gap24,
              HighlightsGrid(),
              gap24,
              Padding(
                padding: EdgeInsets.only(left: 12, right: 24),
                child: TitleBtnWidget(
                  title: AppStrings.teachersStr,
                  onPress: () {
                    ref.read(selectedHighlight.notifier).state = null;
                    ref.read(searchValProvider.notifier).state = null;
                    ref.read(filtersControllerProvider.notifier).clearFilters();
                    Navigator.pushNamed(context, TeachersScreen.routeName);
                  },
                ),
              ),
              gap4,
              TeachersHorizontalList(teachers: data.teachers),
              gap16,
              Padding(
                padding: EdgeInsets.only(left: 12, right: 24),
                child: TitleBtnWidget(
                  title: AppStrings.academiesStr,
                  onPress: () {
                    ref.read(selectedHighlight.notifier).state = null;
                    ref.read(searchValProvider.notifier).state = null;
                    ref.read(filtersControllerProvider.notifier).clearFilters();
                    Navigator.pushNamed(context, AcademiesScreen.routeName);
                  },
                ),
              ),
              gap4,
              AcademiesHorizontalList(academies: data.academies),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AdvanceLoading extends StatelessWidget {
  const AdvanceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Skeletonizer(
          child: const Padding(
            padding: paddingH24,
            child: TitleWidget(title: AppStrings.subjectsStr),
          ),
        ),
        gap12,
        Skeletonizer(
          child: SubjectsHorizontalList(subjects: SubjectModel.dummySubjects),
        ),
        gap24,
        Skeletonizer(child: HighlightsGrid()),
        gap24,
        Skeletonizer(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 24),
            child: TitleBtnWidget(
              title: AppStrings.teachersStr,
              onPress: () {},
            ),
          ),
        ),
        gap4,
        Skeletonizer(
          child: TeachersHorizontalList(teachers: TeacherModel.dummyTeachers),
        ),
        gap16,
        Skeletonizer(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 24),
            child: TitleBtnWidget(
              title: AppStrings.academiesStr,
              onPress: () {},
            ),
          ),
        ),
        gap4,
        Skeletonizer(
          child: AcademiesHorizontalList(
            academies: AcademyModel.dummyAcademies,
          ),
        ),
      ],
    );
  }
}
