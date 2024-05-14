import 'package:education_app/src/common_widgets/teacher_academy_main_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../model/academy_model.dart';
import '../../../academy_details_screen.dart';

class AcademiesHorizontalList extends StatelessWidget {
  const AcademiesHorizontalList({super.key, required this.academies});

  final List<AcademyModel> academies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.length180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => AcademyCard(academy: academies[index]),
        separatorBuilder: (_, __) => gapH8,
        itemCount: academies.length,
      ),
    );
  }
}

class AcademyCard extends StatelessWidget {
  const AcademyCard({super.key, required this.academy});

  final AcademyModel academy;

  @override
  Widget build(BuildContext context) {
    return TeacherAcademyMainCard(
      press: () => Navigator.pushNamed(
        context,
        AcademyDetailsScreen.routeName,
        arguments: academy.id,
      ),
      imageUrl: academy.imageUrl,
      title: academy.title,
      city: academy.city,
      region: academy.region,
      description: academy.description,
    );
  }
}
