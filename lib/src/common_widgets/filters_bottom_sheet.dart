import 'package:education_app/src/application/filters_service.dart';
import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/primary_outlined_btn.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/current_filters_model.dart';
import 'package:education_app/src/presentation/controllers/selected_filters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import 'drop_down_menu_widget.dart';

void filtersBottomSheet({
  required BuildContext context,
  required TeachingType type,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) => BottomSheet(type: type),
  );
}

class BottomSheet extends ConsumerWidget {
  const BottomSheet({super.key, required this.type});

  final TeachingType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(filtersProvider);

    // DropDownMenuWidget width
    final width = (AppSizes.screenWidth / 2) - 4 - 24;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: ColoredBox(
        color: Colors.white,
        child: SizedBox(
          height: AppSizes.screenHeight * 0.5,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 32,
              top: 16,
            ),
            child: AsyncWidget(
                value: value,
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          AppStrings.advancedSearchStr,
                          style: AppTextStyles.textSemiBoldSlateStyle16,
                        ),
                      ),
                      gap32,
                      Row(
                        children: [
                          // cities
                          DropDownMenuWidget(
                            currentVal: ref.read(currentFiltersProvider).city,
                            width: width,
                            hintText: AppStrings.cityStr,
                            items: data.cities,
                            onItemSelected: (val) => ref
                                .read(currentFiltersProvider.notifier)
                                .update((s) => s.copyWith(city: val)),
                          ),
                          gapH8,
                          // countries
                          Consumer(builder: (_, ref, child) {
                            ref.watch(currentFiltersProvider);
                            return DropDownMenuWidget(
                              currentVal:
                                  ref.read(currentFiltersProvider).country,
                              width: width,
                              hintText: AppStrings.countryStr,
                              items: data.getCityByCountryName(
                                  ref.read(currentFiltersProvider).city),
                              onItemSelected: (val) => ref
                                  .read(currentFiltersProvider.notifier)
                                  .update((s) => s.copyWith(country: val)),
                            );
                          }),
                        ],
                      ),
                      gap20,
                      type == TeachingType.teacher
                          ? Row(
                              children: [
                                // levels
                                DropDownMenuWidget(
                                  currentVal:
                                      ref.read(currentFiltersProvider).level,
                                  width: width,
                                  hintText: AppStrings.stageStr,
                                  items: data.levels,
                                  onItemSelected: (val) => ref
                                      .read(currentFiltersProvider.notifier)
                                      .update((s) => s.copyWith(level: val)),
                                ),
                                gapH8,
                                // subjects
                                DropDownMenuWidget(
                                  currentVal:
                                      ref.read(currentFiltersProvider).subject,
                                  width: width,
                                  hintText: AppStrings.subjectStr,
                                  items: data.subjects,
                                  onItemSelected: (val) => ref
                                      .read(currentFiltersProvider.notifier)
                                      .update((s) => s.copyWith(subject: val)),
                                ),
                              ],
                            )
                          : DropDownMenuWidget(
                              currentVal:
                                  ref.read(currentFiltersProvider).subject,
                              width: AppSizes.screenWidth - 24 - 24,
                              hintText: AppStrings.subjectStr,
                              items: data.subjects,
                              onItemSelected: (val) => ref
                                  .read(currentFiltersProvider.notifier)
                                  .update((s) => s.copyWith(subject: val)),
                            ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: AppSizes.length48,
                              child: PrimaryOutlinedBtn(
                                text: AppStrings.cancelStr,
                                press: () {
                                  ref
                                      .read(currentFiltersProvider.notifier)
                                      .update((state) => CurrentFiltersModel());
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          gapH8,
                          Expanded(
                            child: SizedBox(
                              height: AppSizes.length48,
                              child: PrimaryElevatedBtn(
                                text: AppStrings.applyStr,
                                press: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
