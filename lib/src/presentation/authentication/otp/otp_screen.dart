import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/presentation/authentication/otp/widgets/otp_textField.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/auth_title_desc_widget.dart';
import '../../../common_widgets/primary_elevated_btn.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/enum.dart';
import '../../controllers/sample_state_controller.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key});

  static const routeName = '/otp_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInSignupControllerProvider, (previous, next) {
      if (!next.value.isLoading && !next.value.hasError) {
        EasyLoading.dismiss();
        // make logout to false it mean user logged in right now
        ref.read(logoutProvider.notifier).state = false;
        // if user complete signup process successfully i will navigate to select profile picture screen
        if (previous != null && previous.formType == FormType.signup) {
          Navigator.pushNamedAndRemoveUntil(
              context,
               SelectProfilePictureScreen.routeName,
             (route) => route.settings.name == '/',
          );
        } else {
          // if user complete signIn process successfully i will navigate to select profile picture screen
          Navigator.popUntil(context, (route) => route.settings.name == '/');
        }
      }
    });

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) =>
          _stopAuthProcess(context: context, didPop: didPop),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            children: [
              const AuthTitleDescWidget(
                title: AppStrings.confirmMobileNumStr,
                description: AppStrings.otpDeliverOnWhatsAppStr,
              ),
              gap8,
              Text(
                ref.read(signInSignupControllerProvider).authentication!.phone,
                style: AppTextStyles.textMediumStyle16.copyWith(
                  color: AppColors.gray600,
                ),
                textDirection: TextDirection.ltr,
              ),
              const Spacer(),
              const OtpTextField(),
              gap32,
              Consumer(
                builder: (_, ref, child) {
                  ref.watch(otpValueProvider);

                  final otp = ref.read(otpValueProvider);

                  return IgnorePointer(
                    ignoring: otp.length != 4,
                    child: PrimaryElevatedBtn(
                      disable: otp.length != 4,
                      press: () => ref
                          .read(signInSignupControllerProvider.notifier)
                          .verifyOtp(otp),
                      text: AppStrings.nextStr,
                    ),
                  );
                },
              ),
              gap32,
              const Spacer(),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  // to show dialog when user click back button to give him warning
  Future<void> _stopAuthProcess({
    required BuildContext context,
    required bool didPop,
  }) async {
    if (didPop) {
      return;
    }
    final value = await showAlertDialog(
      context: context,
      title: AppStrings.warningStr,
      content: AppStrings.stopAuthProcessStr,
      cancelActionText: AppStrings.noStr,
    );
    if (context.mounted) {
      value! ? Navigator.pop(context) : null;
    }
  }
}
