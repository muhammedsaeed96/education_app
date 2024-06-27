import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/empty_widget.dart';
import 'package:education_app/src/common_widgets/title_widget.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/visitor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/adderss_widget.dart';
import '../core/constants/app_text_styles.dart';
import '../model/student_model.dart';

class VisitorsScreen extends ConsumerStatefulWidget{
  const VisitorsScreen({super.key});

  @override
  ConsumerState<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends ConsumerState<VisitorsScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('VisitorsScreen Build');
    final value = ref.watch(
      getVisitorsProvider(
        ref.read(asyncInitProvider).localStorage.getUserInfo()?.accountType ??
            AccountType.STUDENT,
      ),
    );

    return AsyncWidget(
      value: value,
      data: (data) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryColor500,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.profileVisitStr,
                        style: AppTextStyles.textMediumStyle14,
                      ),
                      gapH6,
                      Text(
                        data.accountVisitorsNumber.toString(),
                        style: AppTextStyles.textMediumStyle16,
                      ),
                    ],
                  ),
                  gap20,
                  Row(
                    children: [
                      Text(
                        AppStrings.studentsContactWithMeStr,
                        style: AppTextStyles.textMediumStyle14,
                      ),
                      gapH6,
                      Text(
                        data.reservationNumbers.toString(),
                        style: AppTextStyles.textMediumStyle16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (data.students.isNotEmpty) ...[
              gap32,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TitleWidget(title: AppStrings.lastStudents),
              ),
            ],
            Expanded(
              child: data.students.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      itemBuilder: (_, i) => VisitorCard(
                        student: data.students[i],
                      ),
                      separatorBuilder: (_, __) => gap16,
                      itemCount: data.students.length,
                    )
                  : const EmptyWidget(
                      text: AppStrings.youDontHaveStudentStr,
                    ),
            ),
          ],
        ),
      ),
      retry: () => ref.invalidate(getVisitorsProvider),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VisitorCard extends StatelessWidget {
  const VisitorCard({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        minVerticalPadding: 20,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            student.name,
            style: AppTextStyles.textSemiBoldStyle12,
          ),
        ),
        subtitle: AddressWidget(
          city: student.province ?? '',
          region: student.area ?? '',
        ),
        trailing: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.gray50, borderRadius: BorderRadius.circular(20)),
          child: Text(
            student.stage ?? '',
            style: AppTextStyles.textSemiBoldStyle10.copyWith(
              color: AppColors.primaryColor500,
            ),
          ),
        ),
      ),
    );
  }
}
