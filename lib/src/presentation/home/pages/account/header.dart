import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/common_widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../controllers/account_controller.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getAccountDataProvider(true));

    return AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getAccountDataProvider),
        data: (data) {
          final (url, name) = getUrlName(data);
          return Column(
            children: [
              ProfileImage(imageUrl: url),
              gap4,
              Text(
                name,
                style: AppTextStyles.textMediumStyle14,
              ),
              gap4,
              Text(
                data.phone,
                style: AppTextStyles.textRegularStyle14.copyWith(
                  color: AppColors.gray500,
                ),
                textDirection: TextDirection.ltr,
              ),
              gap32,
            ],
          );
        });
  }

  (String? imageUrl, String name) getUrlName(data) {
    if (data is StudentModel || data is TeacherModel) {
      return (data.imageUrl.toString().getFullUrl, data.name);
    } else {
      final academy = data as AcademyModel;
      return (academy.imageUrl, academy.title);
    }
  }
}
