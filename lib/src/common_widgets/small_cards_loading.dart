import 'package:education_app/src/common_widgets/teacher_academy_small_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../model/teacher_model.dart';

class SmallCardsLoading extends StatelessWidget {
  const SmallCardsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 32),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final teacher = TeacherModel.dummyTeachers[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Skeletonizer(
              child: TeacherAcademySmallCard(
                title: teacher.name,
                imageUrl: teacher.imageUrl,
                city: teacher.province!.name,
                region: teacher.area!.name,
                discount: teacher.discount,
                discountEndDate: teacher.discountEndDate,
                press: () {},
              ),
            ),
          );
        }, childCount: TeacherModel.dummyTeachers.length),
      ),
    );
  }
}
