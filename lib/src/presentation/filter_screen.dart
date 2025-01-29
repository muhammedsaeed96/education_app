import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/drop_down_menu_widget.dart';
import '../common_widgets/primary_elevated_btn.dart';
import '../common_widgets/primary_outlined_btn.dart';
import '../common_widgets/title_dynamic_widget.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/enum.dart';
import '../data/home_repository.dart';
import 'controllers/academy_controller.dart';
import 'controllers/filter_controller.dart';
import 'controllers/teacher_controller.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  static const routeName = '/filter_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    final width = (size.width / 2) - 4 - 24;
    final data = ref.read(getHomeDataProvider).value!;
    final highlight = ref.read(selectedHighlight);
    final type = ModalRoute.of(context)?.settings.arguments as SearchType;

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.advancedSearchStr)),
      body: ListView(
        padding:
            const EdgeInsets.only(left: 24, top: 32, right: 24, bottom: 16),
        children: [
          Row(
            children: [
              // provinces
              TitleDynamicWidget(
                title: AppStrings.provinceStr,
                widget: DropDownMenuWidget(
                  currentVal: ref.read(filtersControllerProvider).provinceId,
                  width: width,
                  items: data.provinces,
                  onItemSelected: (val) {
                    ref
                        .read(filtersControllerProvider.notifier)
                        .updateSelectedProvince(val);
                  },
                ),
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
                      child: TitleDynamicWidget(
                        title: AppStrings.areaStr,
                        widget: DropDownMenuWidget(
                          currentVal:
                              ref.read(filtersControllerProvider).areaId,
                          width: width,
                          items: areas,
                          onItemSelected: (val) {
                            ref
                                .read(filtersControllerProvider.notifier)
                                .updateSelectedArea(val);
                          },
                        ),
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

                    TitleDynamicWidget(
                        title: AppStrings.stageStr,
                        widget: DropDownMenuWidget(
                          currentVal:
                              ref.read(filtersControllerProvider).stageId,
                          width: width,
                          items: data.stages,
                          onItemSelected: (val) => ref
                              .read(filtersControllerProvider.notifier)
                              .updateSelectedStage(val),
                        )),

                    gapH8,
                    // subjects
                    TitleDynamicWidget(
                      title: AppStrings.subjectStr,
                      widget: DropDownMenuWidget(
                        currentVal:
                            ref.read(filtersControllerProvider).subjectId,
                        width: width,
                        items: data.subjects,
                        onItemSelected: (val) => ref
                            .read(filtersControllerProvider.notifier)
                            .updateSelectedSubject(val),
                      ),
                    ),
                  ],
                )
              : TitleDynamicWidget(
                  title: AppStrings.stageStr,
                  widget: DropDownMenuWidget(
                    currentVal: ref.read(filtersControllerProvider).stageId,
                    width: size.width - 24 - 24,
                    items: data.stages,
                    onItemSelected: (val) {
                      ref
                          .read(filtersControllerProvider.notifier)
                          .updateSelectedStage(val);
                    },
                  ),
                ),
          if (highlight != HighlightType.online &&
              highlight != HighlightType.onsite &&
              type.isSearchOnTeacher) ...[
            gap20,
            SelectTeachingType(),
            gap20,
            SelectTeachingPlace(),
          ],
          if (highlight != HighlightType.outstanding &&
              type.isSearchOnTeacher) ...[
            gap20,
            SelectCurriculum(),
          ],
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: AppSizes.length48,
                child: PrimaryOutlinedBtn(
                  text: AppStrings.cancelStr,
                  press: () {
                    ref.read(filtersControllerProvider.notifier).clearFilters();
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
      ),
    );
  }
}

class SelectTeachingType extends ConsumerWidget {
  const SelectTeachingType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersControllerProvider);

    return TitleDynamicWidget(
      title: AppStrings.teachingTypeStr,
      widget: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            final type = TeacherTeachingType.values[i];

            final isSelected = type.name == filters.teachingType;

            return ChoiceChip(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 12),
              labelStyle: AppTextStyles.textSemiBoldStyle14.copyWith(
                color: isSelected ? Colors.white : null,
              ),
              label: Container(
                height: 48,
                alignment: Alignment.center,
                child: Text(_getTitle(type)),
              ),
              showCheckmark: false,
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  ref
                      .read(filtersControllerProvider.notifier)
                      .updateSelectedTeachingType(type);
                }
              },
            );
          },
          separatorBuilder: (_, __) => gapH6,
          itemCount: TeacherTeachingType.values.length,
        ),
      ),
    );
  }

  String _getTitle(TeacherTeachingType type) {
    if (type == TeacherTeachingType.ALL) {
      return AppStrings.all;
    }

    if (type == TeacherTeachingType.ONLINE) {
      return AppStrings.online;
    }

    return AppStrings.onsite;
  }
}

class SelectCurriculum extends ConsumerWidget {
  const SelectCurriculum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersControllerProvider);

    return TitleDynamicWidget(
      title: AppStrings.curriculumType,
      widget: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            final curriculum = CurriculumType.values[i];

            final isSelected = curriculum.name == filters.curriculumType;

            return ChoiceChip(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 12),
              labelStyle: AppTextStyles.textSemiBoldStyle14.copyWith(
                color: isSelected ? Colors.white : null,
              ),
              label: Container(
                height: 48,
                alignment: Alignment.center,
                child: Text(_getTitle(curriculum)),
              ),
              showCheckmark: false,
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  ref
                      .read(filtersControllerProvider.notifier)
                      .updateSelectedCurriculum(curriculum);
                }
              },
            );
          },
          separatorBuilder: (_, __) => gapH6,
          itemCount: TeacherTeachingType.values.length,
        ),
      ),
    );
  }

  String _getTitle(CurriculumType type) {
    if (type == CurriculumType.all) {
      return AppStrings.all;
    }

    if (type == CurriculumType.outstanding) {
      return AppStrings.outstandingCurriculum;
    }

    return AppStrings.ordinaryCurriculum;
  }
}

class SelectTeachingPlace extends ConsumerWidget {
  const SelectTeachingPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersControllerProvider);

    return TitleDynamicWidget(
      title: AppStrings.teachingPlace,
      widget: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            final place = TeachingPlace.values[i];

            final isSelected = place.name == filters.teachingPlace;

            return ChoiceChip(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 12),
              labelStyle: AppTextStyles.textSemiBoldStyle14.copyWith(
                color: isSelected ? Colors.white : null,
              ),
              label: Container(
                height: 48,
                alignment: Alignment.center,
                child: Text(_getTitle(place)),
              ),
              showCheckmark: false,
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  ref
                      .read(filtersControllerProvider.notifier)
                      .updateSelectedTeachingPlace(place);
                }
              },
            );
          },
          separatorBuilder: (_, __) => gapH6,
          itemCount: TeacherTeachingType.values.length,
        ),
      ),
    );
  }

  String _getTitle(TeachingPlace type) {
    if (type == TeachingPlace.all) {
      return AppStrings.all;
    }

    if (type == TeachingPlace.studentHome) {
      return AppStrings.studentHome;
    }

    return AppStrings.teacherLocation;
  }
}
