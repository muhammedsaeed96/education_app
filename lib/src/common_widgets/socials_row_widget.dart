import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/url_launcher_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/async_init.dart';
import '../presentation/authentication/sign_in_signup_screen.dart';
import '../presentation/controllers/simple_state_controller.dart';
import 'alert_dialogs.dart';
import 'zoom_tap_animation.dart';

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
              gap12,
              SizedBox(
                height: getProportionateScreenHeight(40),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (youtubeUrl.isNotEmpty) ...[
                      SocialButtonWidget(
                        iconPath: Assets.icYoutube,
                        url: youtubeUrl,
                      ),
                      gapH16,
                    ],
                    if (facebookUrl.isNotEmpty) ...[
                      SocialButtonWidget(
                        iconPath: Assets.icFacebook,
                        url: facebookUrl,
                      ),
                      gapH16,
                    ],
                    if (instagramUrl.isNotEmpty) ...[
                      SocialButtonWidget(
                        iconPath: Assets.icInstagram,
                        url: instagramUrl,
                      ),
                      gapH16,
                    ],
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

class SocialButtonWidget extends ConsumerWidget {
  const SocialButtonWidget({
    super.key,
    required this.url,
    required this.iconPath,
  });

  final String url;
  final String iconPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenHeight(40),
      child: ZoomTapAnimation(
        onTap: () => _launchSocialLink(
          context: context,
          ref: ref,
          url: url,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: getProportionateScreenHeight(36),
            height: getProportionateScreenHeight(36),
          ),
        ),
      ),
    );
  }

  Future<void> _launchSocialLink({
    required BuildContext context,
    required WidgetRef ref,
    required String url,
  }) async {
    final storage = ref.read(asyncInitProvider).localStorage;

    if (!storage.isAuth) {
      final result = await loginAlertDialog(
        context: context,
        content: AppStrings.loginToAccessLinkStr,
      );
      if (result != null && result) {
        ref.read(loginToContactWithTeacherAcademy.notifier).state = true;
        Navigator.pushNamed(context, SignInSignupScreen.routeName);
        return;
      }
    } else {
      UrlLauncherHelper.launchUrlByType(url, LinkType.link);
    }
  }
}
