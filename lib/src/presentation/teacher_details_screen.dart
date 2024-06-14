import 'dart:ffi';

import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/custom_network_image.dart';
import 'package:education_app/src/common_widgets/teacher_academy_socials.dart';
import 'package:education_app/src/common_widgets/title_card.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/data/visitor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_widgets/title_desc_widget.dart';
import '../core/utils/url_launcher_helper.dart';
import '../data/teachers_repository.dart';

class TeacherDetailsScreen extends ConsumerWidget {
  const TeacherDetailsScreen({super.key});

  static const routeName = '/teacher_details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    final value = ref.watch(getTeacherByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.teacherDetailsStr)),
      body: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getTeacherByIdProvider(id)),
        data: (teacher) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            children: [
              Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: teacher.imageUrl.getFullUrl,
                    height: AppSizes.length96,
                    width: AppSizes.length96,
                    radius: AppSizes.length96 / 2,
                  ),
                  gap4,
                  Text(
                    teacher.name,
                    style: AppTextStyles.textBoldStyle16,
                  ),
                  gap2,
                  Text(
                    teacher.phone,
                    style: AppTextStyles.textSemiBoldStyle14.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
              gap24,
              TitleDescWidget(
                title: AppStrings.aboutTeacherStr,
                description: teacher.description,
              ),
              gap16,
              Text(
                AppStrings.studyStagesStr,
                style: AppTextStyles.textSemiBoldStyle12,
              ),
              gap4,
              // stages list
              SizedBox(
                height: AppSizes.length32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final stage = teacher.stages[index];
                    return TitleCard(title: stage.name);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: teacher.stages.length,
                ),
              ),
              gap16,
              Text(
                AppStrings.majorStr,
                style: AppTextStyles.textSemiBoldStyle12,
              ),
              gap4,
              // subjects list
              SizedBox(
                height: AppSizes.length32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final subject = teacher.subjects[index];
                    return TitleCard(title: subject.name);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: teacher.subjects.length,
                ),
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.titleStr,
                description:
                    '${teacher.province!.name} / ${teacher.area!.name}',
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.locationDescriptionStr,
                description: teacher.locationDescription,
              ),
              gap16,
              TeacherAcademySocials(
                phone: teacher.phone,
                socials: teacher.socials,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: value.hasError || value.isLoading
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: SizedBox(
                height: AppSizes.length48,
                child: ElevatedButton.icon(
                  onPressed: () => _contactWithTeacher(
                    context: context,
                    ref: ref,
                    phone: value.value?.phone ?? '',
                    id: value.value?.id ?? '',
                  ),
                  icon: SvgPicture.asset(
                    Assets.icPhoneFill,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text(
                    AppStrings.contactWithTeacher,
                    style: AppTextStyles.textSemiBoldStyle14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _contactWithTeacher({
    required BuildContext context,
    required WidgetRef ref,
    required String id,
    required String phone,
  }) async {
    final storage = ref.read(asyncInitProvider).localStorage;

    final isAuth = storage.isStudentAuth;

    if (!isAuth) {
      showAlertDialog(
        context: context,
        title: AppStrings.notifyStr,
        content: AppStrings.loginToCommunicateWithTeacherStr,
      );
      return;
    }

    if (storage.getUserInfo()?.accountType == AccountType.STUDENT) {
      ref.read(visitorRepositoryProvider).createVisitors(
            id: id,
            type: TeachingType.teacher,
          );
    }

    UrlLauncherHelper.launchUrlByType(phone, LinkType.phone);
  }
}
