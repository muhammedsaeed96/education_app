import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/controllers/academy_controller.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:education_app/src/presentation/controllers/student_academies_provider.dart';
import 'package:education_app/src/presentation/controllers/student_teachers_provider.dart';
import 'package:education_app/src/presentation/controllers/teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/assets.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({
    super.key,
    required this.hintTextStr,
    required this.type,
  });

  final String hintTextStr;
  final SearchType type;

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (p) => FocusManager.instance.primaryFocus?.unfocus(),
      style: AppTextStyles.textMediumStyle14,
      controller: controller,
      onChanged: (val) {
        ref.read(searchValProvider.notifier).update((state) => val);
        _applyFiltersByType();
      },
      decoration: InputDecoration(
        hintText: widget.hintTextStr,
        prefixIconConstraints: BoxConstraints(
          minWidth: AppSizes.length24,
          minHeight: AppSizes.length24,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: SvgPicture.asset(Assets.icSearch),
        ),
      ),
    );
  }

  void _applyFiltersByType() {
    switch (widget.type) {
      case SearchType.teacher:
        ref.read(teacherControllerProvider.notifier).applyFiltersAndSearch();
        break;
      case SearchType.academy:
        ref.read(academyControllerProvider.notifier).applyFiltersAndSearch();
        break;
      case SearchType.studentTeachers:
        ref
            .read(studentTeachersControllerProvider.notifier)
            .applyFiltersAndSearch();
        break;
      case SearchType.studentAcademies:
        ref
            .read(studentAcademiesControllerProvider.notifier)
            .applyFiltersAndSearch();
        break;
      case SearchType.teacherStudents:
        // TODO : later
        break;
      case SearchType.academyStudents:
      // TODO : later
        break;
    }
  }
}
