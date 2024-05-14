import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    return SizedBox(
      height: AppSizes.length126,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => SubjectCard(subject: subjects[index]),
        separatorBuilder: (_, __) => gapH8,
        itemCount: subjects.length,
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.subject});

  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      radius: 24,
      tap: () {
        //TODO implement on tap
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
                SvgPicture.asset(
                  height: AppSizes.length48,
                  width: AppSizes.length48,
                  subject.iconUrl!,
                  colorFilter: const ColorFilter.mode(
                    AppColors.gray100,
                    BlendMode.srcIn,
                  ),
                ),
                gap12,
                Text(
                  subject.title,
                  style: AppTextStyles.textSemiBoldSlateStyle18.copyWith(
                    color: AppColors.gray100,
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
