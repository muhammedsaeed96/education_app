import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:education_app/src/presentation/home/pages/account/header.dart';
import 'package:education_app/src/presentation/personal_profile/personal_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/assets.dart';
import 'account_card.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: <Widget>[
        const Header(),
        AccountCard(
          title: AppStrings.accountInfoStr,
          icon: Assets.icUser,
          press: () => Navigator.pushNamed(
            context,
            PersonalProfileScreen.routeName,
          ),
        ),
        gap12,
        AccountCard(
          title: AppStrings.privacyStr,
          icon: Assets.icPrivacy,
          press: () {},
        ),
        gap12,
        AccountCard(
          title: AppStrings.shareAppStr,
          icon: Assets.icShare,
          press: () {},
        ),
        gap12,
        AccountCard(
          title: AppStrings.rateAppStr,
          icon: Assets.icStar,
          press: () {},
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
          press: () {},
        ),
      ],
    );
  }

  Future<void> _logout(
      {required BuildContext context, required WidgetRef ref}) async {
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
      EasyLoading.show();
      await ref.read(asyncInitProvider).localStorage.removeUserInfo();
      EasyLoading.dismiss();
      // set logout state to true it mean user logout
      ref.read(logoutProvider.notifier).state = true;
    }
  }
}
