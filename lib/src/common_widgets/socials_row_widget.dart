import 'package:education_app/src/common_widgets/custom_inkwell.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/url_launcher_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_text_styles.dart';

class SocialsRowWidget extends StatelessWidget {
  const SocialsRowWidget({
    super.key,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.telegramUrl,
    required this.youtubeUrl,
  });

  final String facebookUrl;
  final String instagramUrl;
  final String telegramUrl;
  final String youtubeUrl;

  @override
  Widget build(BuildContext context) {
    return facebookUrl.isNotEmpty ||
            youtubeUrl.isNotEmpty ||
            instagramUrl.isNotEmpty ||
            telegramUrl.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.socialsStr,
                style: AppTextStyles.textSemiBoldStyle12,
              ),
              gap4,
              SizedBox(
                height: getProportionateScreenHeight(40),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    facebookUrl.isNotEmpty
                        ? SocialButtonWidget(
                            iconPath: Assets.icFacebook,
                            url: facebookUrl,
                          )
                        : SizedBox.shrink(),
                    instagramUrl.isNotEmpty
                        ? SocialButtonWidget(
                            iconPath: Assets.icInstagram,
                            url: instagramUrl,
                          )
                        : SizedBox.shrink(),
                    youtubeUrl.isNotEmpty
                        ? SocialButtonWidget(
                            iconPath: Assets.icYoutube,
                            url: youtubeUrl,
                          )
                        : SizedBox.shrink(),
                    telegramUrl.isNotEmpty
                        ? SocialButtonWidget(
                            iconPath: Assets.icTelegram,
                            url: telegramUrl,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.url,
    required this.iconPath,
  });

  final String url;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenHeight(40),
      child: CustomInkwell(
        radius: getProportionateScreenHeight(40) / 2,
        tap: () => UrlLauncherHelper.launchUrlByType(url, LinkType.link),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: getProportionateScreenHeight(30),
            height: getProportionateScreenHeight(30),
          ),
        ),
      ),
    );
  }
}
