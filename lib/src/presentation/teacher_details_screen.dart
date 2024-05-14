import 'package:education_app/src/application/teachers_service.dart';
import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/custom_network_image.dart';
import 'package:education_app/src/common_widgets/title_card.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_widgets/title_desc_widget.dart';
import '../core/utils/url_launcher_helper.dart';

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
        data: (teacher) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            children: [
              Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: teacher.imageUrl,
                    height: AppSizes.length96,
                    width: AppSizes.length96,
                    radius: AppSizes.length96 / 2,
                  ),
                  gap4,
                  Text(
                    teacher.name,
                    style: AppTextStyles.textBoldSlateStyle16,
                  ),
                  gap2,
                  Text(
                    teacher.phone,
                    style: AppTextStyles.textSemiBoldSlateStyle12.copyWith(
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
                style: AppTextStyles.textSemiBoldSlateStyle12,
              ),
              gap4,
              // stages list
              SizedBox(
                height: AppSizes.length32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final stage = teacher.stages[index];
                    return TitleCard(title: stage.title);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: teacher.stages.length,
                ),
              ),
              gap16,
              Text(
                AppStrings.majorStr,
                style: AppTextStyles.textSemiBoldSlateStyle12,
              ),
              gap4,
              // subjects list
              SizedBox(
                height: AppSizes.length32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final subject = teacher.subjects[index];
                    return TitleCard(title: subject.title);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: teacher.subjects.length,
                ),
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.titleStr,
                description: '${teacher.city} / ${teacher.region}',
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.locationDescriptionStr,
                description: teacher.locationDescription,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: value.hasError || value.isLoading
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: SizedBox(
                height: AppSizes.length48,
                child: ElevatedButton.icon(
                  onPressed: () => UrlLauncherHelper.launchUrlByType(
                    value.value!.phone,
                    UrlType.phone,
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
                    style: AppTextStyles.textSemiBoldSlateStyle14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
