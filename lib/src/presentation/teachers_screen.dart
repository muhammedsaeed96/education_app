import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import '../common_widgets/teacher_academy_small_card.dart';
import '../common_widgets/search_filter_row.dart';
import '../core/constants/app_sizes.dart';
import '../model/teacher_model.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  static const routeName = '/teachers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.teachersStr)),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            const SearchFilterRow(
              hintText: AppStrings.searchOnTeacherStr,
              type: TeachingType.teacher,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (_, index) {
                  final teacher = dummyTeachers[index];
                  return TeacherAcademySmallCard(
                    title: teacher.name,
                    imageUrl: teacher.imageUrl,
                    city: teacher.city,
                    region: teacher.region,
                    press: () => Navigator.pushNamed(
                      context,
                      TeacherDetailsScreen.routeName,
                      arguments: teacher.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => gap12,
                itemCount: dummyTeachers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
