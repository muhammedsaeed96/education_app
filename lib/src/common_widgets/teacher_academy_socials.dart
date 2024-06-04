import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/social_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/url_launcher_helper.dart';

class TeacherAcademySocials extends StatelessWidget {
  const TeacherAcademySocials({
    super.key,
    required this.phone,
    required this.socials,
  });

  final String phone;
  final List<SocialModel> socials;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.socialsStr,
          style: AppTextStyles.textSemiBoldStyle12,
        ),
        gap12,
        SizedBox(
          height: getProportionateScreenHeight(32),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => gapH20,
            itemBuilder: (_, i) {
              if (i == socials.length) {
                return SocialWidget(
                  type: CommunicationType.whatsapp,
                  url: phone,
                );
              }
              final social = socials[i];
              return SocialWidget(
                type: social.type,
                url: social.url,
              );
            },
            itemCount: socials.length + 1,
          ),
        ),
      ],
    );
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key, required this.type, required this.url});

  final CommunicationType type;
  final String url;

  @override
  Widget build(BuildContext context) {
    final size = getProportionateScreenHeight(
      type == CommunicationType.whatsapp ? 30.5 : 32,
    );
    return GestureDetector(
      onTap: () => UrlLauncherHelper.launchUrlByType(url, type),
      child: SvgPicture.asset(
        type == CommunicationType.whatsapp
            ? Assets.icWhatsapp
            : type == CommunicationType.facebook
                ? Assets.icFacebook
                : Assets.icYoutube,
        width: size,
        height: size,
      ),
    );
  }
}
