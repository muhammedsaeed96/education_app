import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/title_btn_widget.dart';
import 'package:education_app/src/common_widgets/title_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/presentation/academies_screen.dart';
import 'package:education_app/src/presentation/home/pages/home/academies_horizontal_list.dart';
import 'package:education_app/src/presentation/home/pages/home/subjects_horizontal_card.dart';
import 'package:education_app/src/presentation/home/pages/home/teachers_horizontal_list.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/home_repository.dart';
import '../../../controllers/filter_controller.dart';
import '../../../controllers/simple_state_controller.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    debugPrint('HOME BUILD');
    super.build(context);
    final value = ref.watch(getHomeDataProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getHomeDataProvider);
      },
      child: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getHomeDataProvider),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              const Padding(
                padding: paddingH24,
                child: TitleWidget(title: AppStrings.subjectsStr),
              ),
              gap20,
              SubjectsHorizontalList(subjects: data.subjects),
              gap32,
              Padding(
                padding: paddingH24,
                child: TitleBtnWidget(
                  title: AppStrings.teachersStr,
                  onPress: () {
                    ref.read(searchValProvider.notifier).state = null;
                    ref.read(filtersControllerProvider.notifier).clearFilters();
                    Navigator.pushNamed(context, TeachersScreen.routeName);
                  },
                ),
              ),
              gap12,
              TeachersHorizontalList(teachers: data.teachers),
              gap32,
              Padding(
                padding: paddingH24,
                child: TitleBtnWidget(
                  title: AppStrings.academiesStr,
                  onPress: () {
                    ref.read(searchValProvider.notifier).state = null;
                    ref.read(filtersControllerProvider.notifier).clearFilters();
                    Navigator.pushNamed(context, AcademiesScreen.routeName);
                  },
                ),
              ),
              gap12,
              AcademiesHorizontalList(academies: data.academies)
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
