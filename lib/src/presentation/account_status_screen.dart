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
    final value = ref.watch(getAccountDataProvider(true));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AsyncWidget(
          value: value,
          data: (data) {
            final (title, desc) = gteTitleDesc(data.status);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.icClockCircle),
                Gap(20),
                Text(title, style: AppTextStyles.textSemiBoldStyle18),
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
                  press: () {
                    ref.refresh(getAccountDataProvider(true)).whenData((data) {
                      if (data.status == AccountStatus.approved.name) {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    });
                  },
                ),
              ],
            );
          },
          retry: () => ref.invalidate(getAccountDataProvider(true)),
        ),
      ),
    );
  }

  (String title, String desc) gteTitleDesc(String status) {
    switch (status) {
      case 'approved':
        return (AppStrings.approved, AppStrings.approvedDesc);
      case 'pending':
        return (AppStrings.pending, AppStrings.pendingDesc);
      default:
        return (AppStrings.rejected, AppStrings.rejectedDesc);
    }
  }
}
