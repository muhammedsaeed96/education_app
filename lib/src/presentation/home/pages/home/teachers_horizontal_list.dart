import 'package:education_app/src/common_widgets/teacher_academy_main_card.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/empty_widget.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/enum.dart';
import '../../../../core/utils/async_init.dart';
import '../../../../data/visitor_repository.dart';
import '../../../teacher_details_screen.dart';

class TeachersHorizontalList extends StatelessWidget {
  const TeachersHorizontalList({super.key, required this.teachers});

  final List<TeacherModel> teachers;

  @override
  Widget build(BuildContext context) {
    return teachers.isEmpty
        ? EmptyWidget(showTextOnly: true)
        : SizedBox(
            height: AppSizes.length180,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => TeacherCard(teacher: teachers[index]),
              separatorBuilder: (_, __) => gapH8,
              itemCount: teachers.length,
            ),
          );
  }
}

class TeacherCard extends ConsumerWidget {
  const TeacherCard({super.key, required this.teacher});

  final TeacherModel teacher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TeacherAcademyMainCard(
      press: () {
        final storage = ref.read(asyncInitProvider).localStorage;
        if (storage.getUserInfo()?.userId != teacher.id) {
          ref.read(visitorRepositoryProvider).createVisitors(
                id: teacher.id,
                type: TeachingType.teacher,
              );
        }
        Navigator.pushNamed(
          context,
          TeacherDetailsScreen.routeName,
          arguments: teacher.id,
        );
      },
      imageUrl: teacher.imageUrl,
      title: teacher.name,
      city: teacher.province!.name,
      region: teacher.area!.name,
      description: teacher.description!,
      visitorsNum: teacher.visitorsNumber,
    );
  }
}
