import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/core/app_theme.dart';
import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
            height: AppSizes.length48,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SubjectCard(subject: subjects[index]),
              ),
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
    return ZoomTapAnimation(
      onTap: () {
        ref.read(filtersControllerProvider.notifier).clearFilters();
        ref
            .read(filtersControllerProvider.notifier)
            .updateSelectedSubject(subject.id);
        Navigator.pushNamed(context, TeachersScreen.routeName);
      },
      child: Container(
        decoration: AppTheme.customDecoration(12),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            subject.iconUrl != null && subject.iconUrl!.endsWith('.svg')
                ? SvgPicture.network(
                    height: AppSizes.length24,
                    width: AppSizes.length24,
                    subject.iconUrl.getFullUrl!,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor400,
                      BlendMode.srcIn,
                    ),
                    placeholderBuilder: (_) {
                      return SizedBox(
                        height: AppSizes.length24,
                        width: AppSizes.length24,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3.0,
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
            Text(
              subject.name,
              style: AppTextStyles.textMediumStyle14,
            ),
          ],
        ),
      ),
    );
  }
}
