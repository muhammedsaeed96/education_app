import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:education_app/src/presentation/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/academies_service.dart';
import '../common_widgets/teacher_academy_small_card.dart';
import '../common_widgets/search_filter_row.dart';
import '../core/constants/app_sizes.dart';

class AcademiesScreen extends ConsumerWidget {
  const AcademiesScreen({super.key});

  static const routeName = '/academies';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getAcademiesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.academiesStr)),
      body: AsyncWidget(
        value: value,
        data: (academies) {
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
            child: Column(
              children: [
                const SearchFilterRow(
                  hintText: AppStrings.searchOnAcademyStr,
                  type: TeachingType.academy,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (_, index) {
                      final academy = academies[index];
                      return TeacherAcademySmallCard(
                        title: academy.title,
                        imageUrl: academy.imageUrl,
                        city: academy.city,
                        region: academy.region,
                        press: () => Navigator.pushNamed(
                          context,
                          AcademyDetailsScreen.routeName,
                          arguments: academy.id,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => gap12,
                    itemCount: academies.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
