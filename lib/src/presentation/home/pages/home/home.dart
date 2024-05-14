import 'package:education_app/src/application/home_service.dart';
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

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getHomeDataProvider);
    return AsyncWidget(
      value: value,
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
                onPress: ()=> Navigator.pushNamed(context, TeachersScreen.routeName),
              ),
            ),
            gap12,
            TeachersHorizontalList(teachers: data.teachers),
            gap32,
            Padding(
              padding: paddingH24,
              child: TitleBtnWidget(
                title: AppStrings.academiesStr,
                onPress: ()=> Navigator.pushNamed(context, AcademiesScreen.routeName),
              ),
            ),
            gap12,
            AcademiesHorizontalList(academies: data.academies)
          ],
        );
      },
    );
  }
}
