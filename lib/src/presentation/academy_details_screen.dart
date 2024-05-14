import 'package:education_app/src/application/academies_service.dart';
import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/custom_network_image.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_widgets/title_card.dart';
import '../common_widgets/title_desc_widget.dart';
import '../core/utils/url_launcher_helper.dart';

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
                    imageUrl: academy.imageUrl,
                    height: AppSizes.length96,
                    width: AppSizes.length96,
                    radius: AppSizes.length96 / 2,
                  ),
                  gap4,
                  Text(
                    academy.title,
                    style: AppTextStyles.textBoldSlateStyle16,
                  ),
                  gap2,
                  Text(
                    academy.phone,
                    style: AppTextStyles.textSemiBoldSlateStyle12.copyWith(
                      color: AppColors.gray500,
                    ),
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
                style: AppTextStyles.textSemiBoldSlateStyle12,
              ),
              gap4,
              // stages list
              SizedBox(
                height: AppSizes.length32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final stage = academy.stages[index];
                    return TitleCard(title: stage.title);
                  },
                  separatorBuilder: (_, __) => gapH4,
                  itemCount: academy.stages.length,
                ),
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.titleStr,
                description: '${academy.city} / ${academy.region}',
              ),
              gap16,
              TitleDescWidget(
                title: AppStrings.locationDescriptionStr,
                description: academy.locationDescription,
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
                    AppStrings.contactWithAcademy,
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
