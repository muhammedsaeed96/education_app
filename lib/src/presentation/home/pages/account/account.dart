import 'package:education_app/src/presentation/home/pages/account/profile_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/assets.dart';
import 'account_card.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: [
        const ProfileImage(
          imageUrl:
              'https://www.clickvieweducation.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fteacher-1.48b5788a.png&w=1080&q=80',
        ),
        gap8,
        AccountCard(
          title: AppStrings.accountInfoStr,
          icon: Assets.icUser,
          press: () {},
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
          press: () {},
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
}
