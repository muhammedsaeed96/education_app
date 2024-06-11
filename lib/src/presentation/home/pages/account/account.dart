import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/core/constants/api_urls.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/core/utils/url_launcher_helper.dart';
import 'package:education_app/src/presentation/about_us_screen.dart';
import 'package:education_app/src/presentation/controllers/account_controller.dart';
import 'package:education_app/src/presentation/home/pages/account/header.dart';
import 'package:education_app/src/presentation/personal_profile/personal_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/assets.dart';
import 'account_card.dart';
import 'package:in_app_review/in_app_review.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      accountControllerProvider,
      (_, next) {
        if (next.isLoading) {
          EasyLoading.show();
        } else if (next.hasError) {
          EasyLoading.dismiss();
          next.showErrorDialog(context);
        } else {
          EasyLoading.dismiss();
        }
      },
    );

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: <Widget>[
        const Header(),
        AccountCard(
          title: AppStrings.accountInfoStr,
          icon: Assets.icUserGray,
          press: () => Navigator.pushNamed(
            context,
            PersonalProfileScreen.routeName,
          ),
        ),
        gap12,
        AccountCard(
          title: AppStrings.rateAppStr,
          icon: Assets.icStar,
          press: _openAppReview,
        ),
        gap12,
        AccountCard(
          title: AppStrings.shareAppStr,
          icon: Assets.icShare,
          press: _shareAppLink,
        ),
        gap12,
        AccountCard(
          title: AppStrings.privacyStr,
          icon: Assets.icPrivacy,
          press: () => UrlLauncherHelper.launchUrlByType(
            ApiUrls.privacyUrl,
            LinkType.link,
          ),
        ),        gap12,
        AccountCard(
          title: AppStrings.aboutAppStr,
          icon: Assets.icInfo,
          press: () => Navigator.pushNamed(context, AboutUsScreen.routeName),
        ),
        gap12,
        AccountCard(
          title: AppStrings.logoutStr,
          icon: Assets.icLogout,
          redColor: true,
          press: () => _logout(context: context, ref: ref),
        ),
        gap12,
        AccountCard(
          title: AppStrings.deleteAccountStr,
          icon: Assets.icTrash,
          redColor: true,
          press: () => _deleteAccount(context: context, ref: ref),
        ),
      ],
    );
  }

  Future<void> _logout({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await showAlertDialog(
      context: context,
      title: AppStrings.logoutStr,
      content: AppStrings.logoutDescStr,
      defaultActionText: AppStrings.yesStr,
      cancelActionText: AppStrings.cancelStr,
      defaultActionBg: AppColors.red500,
    );
    // if result true it mean user click confirm button
    if (result == true) {
      await ref.read(accountControllerProvider.notifier).logout();
    }
  }

  Future<void> _deleteAccount({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final result = await showAlertDialog(
      context: context,
      title: AppStrings.deleteAccountInDialogStr,
      content: AppStrings.areYouSureToDeleteYourAccount,
      defaultActionText: AppStrings.yesStr,
      cancelActionText: AppStrings.cancelStr,
      defaultActionBg: AppColors.red500,
    );
    // if result true it mean user click confirm button
    if (result == true) {
      await ref.read(accountControllerProvider.notifier).deleteAccount();
    }
  }

  // to show app rating bottom sheet
  void _openAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void _shareAppLink() async {
    final result = await Share.share('https://www.hojuzat.com');
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing my website!');
    }
  }
}
