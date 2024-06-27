import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/assets.dart';
import '../core/enum.dart';
import '../core/utils/async_init.dart';
import '../core/utils/url_launcher_helper.dart';
import '../data/visitor_repository.dart';
import 'alert_dialogs.dart';

class CallsBtns extends ConsumerWidget {
  const CallsBtns({super.key, this.phone, this.id, required this.type});

  final String? phone;
  final String? id;
  final TeachingType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
        bottom: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: AppSizes.length48,
            child: ElevatedButton.icon(
              onPressed: () => _contactWithTeacherOrAcademy(
                context: context,
                ref: ref,
                phone: phone ?? '',
                id: id ?? '',
                type: LinkType.phone,
                teachingType: type,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              icon: SvgPicture.asset(
                height: AppSizes.length28,
                width: AppSizes.length28,
                Assets.icPhoneFill,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              label: Text(
                AppStrings.callNowStr,
                style: AppTextStyles.textSemiBoldStyle14.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          gap16,
          SizedBox(
            height: AppSizes.length48,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primaryColor50,
                side: const BorderSide(
                  width: 1.5,
                  color: AppColors.primaryColor500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () => _contactWithTeacherOrAcademy(
                context: context,
                ref: ref,
                phone: phone ?? '',
                id: id ?? '',
                type: LinkType.whatsapp,
                teachingType: type,
              ),
              icon: SvgPicture.asset(
                height: AppSizes.length30,
                width: AppSizes.length30,
                Assets.icWhatsappIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor400,
                  BlendMode.srcIn,
                ),
              ),
              label: Text(
                AppStrings.contactByWhatsappStr,
                style: AppTextStyles.textSemiBoldStyle14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _contactWithTeacherOrAcademy({
    required BuildContext context,
    required WidgetRef ref,
    required String id,
    required String phone,
    required LinkType type,
    required TeachingType teachingType,
  }) async {
    final storage = ref.read(asyncInitProvider).localStorage;

    final isAuth = storage.isStudentAuth;

    if (!isAuth) {
      showAlertDialog(
        context: context,
        title: AppStrings.notifyStr,
        content: AppStrings.loginToCommunicateWithTeacherStr,
      );
      return;
    }

    if (storage.getUserInfo()?.accountType == AccountType.STUDENT) {
      ref.read(visitorRepositoryProvider).createVisitors(
            id: id,
            type: teachingType,
          );
    }

    UrlLauncherHelper.launchUrlByType(phone, type);
  }
}
