import 'package:education_app/src/common_widgets/teacher_academy_main_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/empty_widget.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/enum.dart';
import '../../../../core/utils/async_init.dart';
import '../../../../data/visitor_repository.dart';
import '../../../../model/academy_model.dart';
import '../../../academy_details_screen.dart';

class AcademiesHorizontalList extends StatelessWidget {
  const AcademiesHorizontalList({super.key, required this.academies});

  final List<AcademyModel> academies;

  @override
  Widget build(BuildContext context) {
    return academies.isEmpty
        ? EmptyWidget(showTextOnly: true)
        : SizedBox(
            height: 180,
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

class AcademyCard extends ConsumerWidget {
  const AcademyCard({super.key, required this.academy});

  final AcademyModel academy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TeacherAcademyMainCard(
      press: () {
        final storage = ref.read(asyncInitProvider).localStorage;
        if (storage.getUserInfo()?.userId != academy.id) {
          ref.read(visitorRepositoryProvider).createVisitors(
                id: academy.id,
                type: TeachingType.academy,
              );
        }
        Navigator.pushNamed(
          context,
          AcademyDetailsScreen.routeName,
          arguments: academy.id,
        );
      },
      imageUrl: academy.imageUrl,
      title: academy.title,
      city: academy.province?.name ?? '',
      region: academy.area?.name ?? '',
      description: academy.description!,
      visitorsNum: academy.visitorsNumber,
    );
  }
}
