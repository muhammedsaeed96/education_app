import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/data/general_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/url_launcher_helper.dart';

class ContactUs extends ConsumerStatefulWidget {
  const ContactUs({super.key});

  @override
  ConsumerState<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends ConsumerState<ContactUs>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    debugPrint('ContactUs BUILD');

    super.build(context);
    final value = ref.watch(getContactInfoProvider);

    return AsyncWidget(
      value: value,
      retry: () => ref.invalidate(getContactInfoProvider),
      data: (data) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          SizedBox(height: getProportionateScreenHeight(8)),
          PrimaryElevatedBtn(
            text: AppStrings.callUsStr,
            width: getProportionateScreenWidth(160),
            height: getProportionateScreenHeight(40),
            radius: 24,
            press: () => UrlLauncherHelper.launchUrlByType(
              data.phone,
              LinkType.phone,
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
              SocialButton(type: LinkType.link, url: data.facebookUrl),
              gapH24,
              SocialButton(type: LinkType.whatsapp, url: data.phone),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SocialButton extends ConsumerWidget {
  const SocialButton({super.key, required this.type, required this.url});

  final LinkType type;
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GestureDetector(
      onTap: () {
        type == LinkType.whatsapp
            ? UrlLauncherHelper.launchUrlByType(url, LinkType.whatsapp)
            : UrlLauncherHelper.launchUrlByType(url, type);
      },
      child: SvgPicture.asset(
        type == LinkType.whatsapp ? Assets.icWhatsappIcon : Assets.icFacebook,
        width: getProportionateScreenHeight(40),
        height:  getProportionateScreenHeight(40),
        colorFilter: type == LinkType.whatsapp
            ? ColorFilter.mode(AppColors.primaryColor400, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
