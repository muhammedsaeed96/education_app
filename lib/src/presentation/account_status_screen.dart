import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/primary_outlined_btn.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/presentation/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/assets.dart';
import '../core/enum.dart';
import '../core/utils/url_launcher_helper.dart';

class AccountStatusScreen extends ConsumerWidget {
  const AccountStatusScreen({super.key});

  static const routeName = 'account_status';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(getAccountDataProvider(true).select((val) => val), (_, next) {
      if (next.hasValue && next.value?.status == 'approved') {
        Navigator.pushReplacementNamed(context, '/');
        return;
      }
    });

    final value = ref.watch(getAccountDataProvider(true));

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AsyncWidget(
            value: value,
            data: (data) {
              final (title, desc, color, icon) = gteTitleDescColorIcon(
                data.status,
              );
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon),
                  Gap(20),
                  Text(
                    title,
                    style: AppTextStyles.textSemiBoldStyle18.copyWith(
                      color: color,
                    ),
                  ),
                  Gap(4),
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textRegularStyle16,
                  ),
                  Gap(20),
                  PrimaryElevatedBtn(
                    text: AppStrings.contactByWhatsappStr,
                    radius: 25,
                    press:
                        () => UrlLauncherHelper.launchUrlByType(
                          AppStrings.phone,
                          LinkType.whatsapp,
                        ),
                  ),
                  Gap(12),
                  PrimaryOutlinedBtn(
                    text: AppStrings.updateStr,
                    radius: 25,
                    bg: AppColors.primaryColor50,
                    borderColor: AppColors.primaryColor500,
                    press: () => ref.invalidate(getAccountDataProvider(true)),
                  ),
                ],
              );
            },
            retry: () => ref.invalidate(getAccountDataProvider(true)),
          ),
        ),
      ),
    );
  }

  (String title, String desc, Color color, String icon) gteTitleDescColorIcon(
    String status,
  ) {
    switch (status) {
      case 'approved':
        return (
          AppStrings.approved,
          AppStrings.approvedDesc,
          AppColors.primaryColor400,
          '',
        );
      case 'pending':
        return (
          AppStrings.pending,
          AppStrings.pendingDesc,
          Colors.orangeAccent,
          Assets.icClockCircle,
        );
      default:
        return (
          AppStrings.rejected,
          AppStrings.rejectedDesc,
          AppColors.red400,
          Assets.icCloseCircle,
        );
    }
  }
}
