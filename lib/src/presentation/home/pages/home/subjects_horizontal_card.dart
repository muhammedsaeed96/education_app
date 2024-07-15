import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common_widgets/custom_inkwell.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

class SubjectsHorizontalList extends StatelessWidget {
  const SubjectsHorizontalList({super.key, required this.subjects});

  final List<SubjectModel> subjects;

  @override
  Widget build(BuildContext context) {
    return subjects.isEmpty
        ? EmptyWidget(showTextOnly: true)
        : SizedBox(
            height: AppSizes.length126,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SubjectCard(subject: subjects[index]),
              ),
              itemExtent:AppSizes.length132,
              itemCount: subjects.length,
            ),
          );
  }
}

class SubjectCard extends ConsumerWidget {
  const SubjectCard({super.key, required this.subject});

  final SubjectModel subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomInkwell(
      radius: 24,
      tap: () {
        ref.read(filtersControllerProvider.notifier).clearFilters();
        ref
            .read(filtersControllerProvider.notifier)
            .updateSelectedSubject(subject.id);
        Navigator.pushNamed(context, TeachersScreen.routeName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.tealGradient),
          child: SizedBox(
            height: AppSizes.length126,
            width: AppSizes.length132,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                subject.iconUrl != null && subject.iconUrl!.endsWith('.svg')
                    ? SvgPicture.network(
                        height: AppSizes.length40,
                        width: AppSizes.length40,
                        subject.iconUrl.getFullUrl!,
                        colorFilter: const ColorFilter.mode(
                          AppColors.gray100,
                          BlendMode.srcIn,
                        ),
                      )
                    : const SizedBox.shrink(),
                gap12,
                Text(
                  subject.name,
                  style: AppTextStyles.textSemiBoldStyle16.copyWith(
                    color: AppColors.gray50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
