import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/controllers/simple_state_controller.dart';

class TeachingOnStudentHomeCheckbox extends StatelessWidget {
  const TeachingOnStudentHomeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer(
          builder: (_, WidgetRef ref, __) {
            ref.watch(isTeacherTeachingOnStudentHome);
            return Checkbox(
              value: ref.read(isTeacherTeachingOnStudentHome),
              onChanged: (e) {
                ref.read(isTeacherTeachingOnStudentHome.notifier).state = e!;
              },
              activeColor: AppColors.primaryColor400,
            );
          },
        ),
        Text(
          AppStrings.teachingOnStudentHome,
          style: AppTextStyles.textRegularStyle14
              .copyWith(color: AppColors.black87),
        ),
      ],
    );
  }
}