import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/primary_outlined_btn.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/presentation/controllers/academy_controller.dart';
import 'package:education_app/src/presentation/controllers/filter_controller.dart';
import 'package:education_app/src/presentation/controllers/teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../data/home_repository.dart';
import 'drop_down_menu_widget.dart';

void filtersBottomSheet({
  required BuildContext context,
  required SearchType type,
}) {
  showModalBottomSheet<void>(
    constraints: const BoxConstraints(minWidth: double.infinity),
    context: context,
    builder: (_) => BottomSheet(type: type),
  );
}

class BottomSheet extends ConsumerWidget {
  const BottomSheet({super.key, required this.type});

  final SearchType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(getHomeDataProvider).value!;

    // DropDownMenuWidget width
    final width = (AppSizes.screenWidth / 2) - 4 - 24;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.advancedSearchStr,
                    style: AppTextStyles.textSemiBoldStyle16,
                  ),
                ),
                gap32,
                Row(
                  children: [
                    // provinces
                    DropDownMenuWidget(
                      currentVal:
                          ref.read(filtersControllerProvider).provinceId,
                      width: width,
                      hintText: AppStrings.provinceStr,
                      items: data.provinces,
                      onItemSelected: (val) {
                        ref
                            .read(filtersControllerProvider.notifier)
                            .updateSelectedProvince(val);
                      },
                    ),
                    gapH8,
                    // areas
                    Consumer(
                      builder: (_, ref, child) {
                        ref.watch(filtersControllerProvider);

                        final areas = ref
                            .read(filtersControllerProvider.notifier)
                            .getAreasByProvinceId();

                        return IgnorePointer(
                          ignoring: areas.isEmpty,
                          child: Opacity(
                            opacity: areas.isEmpty ? 0.5 : 1,
                            child: DropDownMenuWidget(
                              currentVal:
                                  ref.read(filtersControllerProvider).areaId,
                              width: width,
                              hintText: AppStrings.areaStr,
                              items: areas,
                              onItemSelected: (val) {
                                ref
                                    .read(filtersControllerProvider.notifier)
                                    .updateSelectedArea(val);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                gap20,
                type == SearchType.teacher
                    ? Row(
                        children: [
                          // levels
                          DropDownMenuWidget(
                            currentVal:
                                ref.read(filtersControllerProvider).stageId,
                            width: width,
                            hintText: AppStrings.stageStr,
                            items: data.stages,
                            onItemSelected: (val) => ref
                                .read(filtersControllerProvider.notifier)
                                .updateSelectedStage(val),
                          ),
                          gapH8,
                          // subjects
                          DropDownMenuWidget(
                            currentVal:
                                ref.read(filtersControllerProvider).subjectId,
                            width: width,
                            hintText: AppStrings.subjectStr,
                            items: data.subjects,
                            onItemSelected: (val) => ref
                                .read(filtersControllerProvider.notifier)
                                .updateSelectedSubject(val),
                          ),
                        ],
                      )
                    : DropDownMenuWidget(
                        currentVal: ref.read(filtersControllerProvider).stageId,
                        width: AppSizes.screenWidth - 24 - 24,
                        hintText: AppStrings.stageStr,
                        items: data.stages,
                        onItemSelected: (val) => ref
                            .read(filtersControllerProvider.notifier)
                            .updateSelectedStage(val),
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
                                .read(filtersControllerProvider.notifier)
                                .clearFilters();
                            type == SearchType.teacher
                                ? ref
                                    .read(teacherControllerProvider.notifier)
                                    .applyFiltersAndSearch()
                                : ref
                                    .read(academyControllerProvider.notifier)
                                    .applyFiltersAndSearch();
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
                          press: () {
                            type == SearchType.teacher
                                ? ref
                                    .read(teacherControllerProvider.notifier)
                                    .applyFiltersAndSearch()
                                : ref
                                    .read(academyControllerProvider.notifier)
                                    .applyFiltersAndSearch();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
