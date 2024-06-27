import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/call_btns.dart';
import 'package:education_app/src/common_widgets/custom_network_image.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/socials_row_widget.dart';
import '../common_widgets/title_card.dart';
import '../common_widgets/title_desc_widget.dart';
import '../data/academey_repository.dart';

class AcademyDetailsScreen extends ConsumerWidget {
  const AcademyDetailsScreen({super.key});

  static const routeName = '/academy_details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    final value = ref.watch(getAcademyByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.academyDetailsStr)),
      body: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getAcademyByIdProvider(id)),
        data: (academy) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 24,
            ),
            children: [
              Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: academy.imageUrl.getFullUrl,
                    height: AppSizes.length96,
                    width: AppSizes.length96,
                    radius: AppSizes.length96 / 2,
                  ),
                  gap4,
                  Text(
                    academy.title,
                    style: AppTextStyles.textBoldStyle16,
                  ),
                  gap2,
                  Text(
                    academy.phone,
                    style: AppTextStyles.textSemiBoldStyle14.copyWith(
                      color: AppColors.gray500,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              gap24,
              TitleDescWidget(
                title: AppStrings.descriptionStr,
                description: academy.description,
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
                    final stage = academy.stages[index];
                    return TitleCard(title: stage.name);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: academy.stages.length,
                ),
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.titleStr,
                description:
                    '${academy.province!.name} / ${academy.area!.name}',
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.locationDescriptionStr,
                description: academy.locationDescription,
              ),
              gap16,
              SocialsRowWidget(
                facebookUrl: academy.facebookUrl ?? '',
                instagramUrl: academy.instagramUrl ?? '',
                telegramUrl: academy.telegramUrl ?? '',
                youtubeUrl: academy.youtubeUrl ?? '',
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: value.hasError || value.isLoading
          ? const SizedBox.shrink()
          : CallsBtns(
              phone: value.value?.phone,
              id: value.value?.id,
              type: TeachingType.academy,
            ),
    );
  }
}
