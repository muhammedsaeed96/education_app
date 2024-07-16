import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/presentation/home/pages/student_communications/tab_item.dart';
import 'package:education_app/src/presentation/home/pages/student_communications/teachers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'academies_view.dart';

class CommunicationsPage extends ConsumerStatefulWidget {
  const CommunicationsPage({super.key});

  @override
  ConsumerState<CommunicationsPage> createState() => _CommunicationsPageState();
}

class _CommunicationsPageState extends ConsumerState<CommunicationsPage> with AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  AppStrings.yourAcademiesAndTeachersStr,
                  style: AppTextStyles.textSemiBoldStyle14,
                ),
              ),
            ),
            gap24,
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Container(
                height: AppSizes.length40,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: AppColors.gray100,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor400,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.gray700,
                  unselectedLabelStyle: AppTextStyles.textMediumStyle16,
                  labelStyle: AppTextStyles.textSemiBoldStyle16,
                  tabs: [
                    TabItem(title: AppStrings.teachersStr),
                    TabItem(title: AppStrings.academiesStr),
                  ],
                ),
              ),
            ),
            Expanded(
              child: const TabBarView(
                children: [TeachersView(), AcademiesView()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
