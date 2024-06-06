import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/teacher_academy_socials.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/data/general_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/url_launcher_helper.dart';

class ContactUs extends ConsumerWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getContactInfoProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getContactInfoProvider),
        data: (data) => Column(
          children: [
            Image.asset(
              Assets.callUs,
              width: getProportionateScreenHeight(250),
              height: getProportionateScreenHeight(250),
            ),
            Text(
              AppStrings.phoneStr,
              style: AppTextStyles.textSemiBoldStyle18,
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Text(
              data.phone,
              style: AppTextStyles.textMediumStyle16.copyWith(
                color: AppColors.gray600,
              ),
              textDirection: TextDirection.ltr,
            ),
            SizedBox(height: getProportionateScreenHeight(6)),
            PrimaryElevatedBtn(
              text: AppStrings.callUsStr,
              width: getProportionateScreenWidth(160),
              height: getProportionateScreenHeight(40),
              radius: 24,
              press: () => UrlLauncherHelper.launchUrlByType(
                data.phone,
                CommunicationType.phone,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Text(
              AppStrings.socialsStr,
              style: AppTextStyles.textSemiBoldStyle18,
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialWidget(
                  type: CommunicationType.facebook,
                  url: data.facebookUrl,
                ),
                gapH24,
                SocialWidget(
                  type: CommunicationType.whatsapp,
                  url: data.phone,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
