import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/presentation/authentication/otp_countdown_timer.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/enum.dart';
import '../controllers/simple_state_controller.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key});

  static const routeName = '/otp_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      press: () => _verifyOtp(
                        context: context,
                        ref: ref,
                        code: otp,
                      ),
                      text: AppStrings.loginStr,
                    ),
                  );
                },
              ),
              gap32,
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: Consumer(
          builder: (_, ref, child) {
            final canReqOtp = ref.watch(requestOtpAvailableProvider);
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 48,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(visible: !canReqOtp, child: OtpCountDownTimer()),
                  gapH6,
                  IgnorePointer(
                    ignoring: !canReqOtp,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _resendOtp(ref),
                      child: Text(
                        AppStrings.resendOtpStr,
                        style: AppTextStyles.textMediumStyle16.copyWith(
                          color: canReqOtp
                              ? AppColors.primaryColor400
                              : AppColors.gray400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _verifyOtp({
    required BuildContext context,
    required WidgetRef ref,
    required String code,
  }) async {
    EasyLoading.show();
    final verifyType =
        await ref.read(signInSignupControllerProvider.notifier).verifyOtp(code);
    EasyLoading.dismiss();

    if (!context.mounted) {
      return;
    }

    if(verifyType != null){
      ref.read(isAuthenticationProvider.notifier).state = true;
    }

    final contactWith = ref.read(loginToContactWithTeacherAcademy);

    if (contactWith && verifyType == FormType.signup) {
      ref.read(loginToContactWithTeacherAcademy.notifier).state = false;
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
    } else if (contactWith && verifyType == FormType.signIn) {
      ref.read(loginToContactWithTeacherAcademy.notifier).state = false;
      Navigator.of(context)
        ..pop()
        ..pop();
    } else if (verifyType == FormType.signup) {
      // if user complete signup process successfully i will navigate him to select profile picture screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        SelectProfilePictureScreen.routeName,
        (route) => route.settings.name == '/',
      );
    } else if (verifyType == FormType.signIn) {
      // if user complete signIn process successfully i will navigate him to home screen
      Navigator.popUntil(context, (route) => route.settings.name == '/');
    }
  }

  void _resendOtp(WidgetRef ref) {
    final controller = ref.read(signInSignupControllerProvider);
    ref.read(signInSignupControllerProvider.notifier).requestOtp(
          phone: controller.authentication?.phone ?? '',
          accountType: controller.accountType,
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
      defaultActionText: AppStrings.yesStr,
      cancelActionText: AppStrings.noStr,
    );
    if (context.mounted) {
      value! ? Navigator.pop(context) : null;
    }
  }
}

class OtpTextField extends ConsumerWidget {
  const OtpTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppSizes.length72,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          showCursor: false,
          autoDisposeControllers: false,
          appContext: context,
          controller: null,
          onChanged: (val) {
            ref.read(otpValueProvider.notifier).update((state) => val);
          },
          length: 4,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: AppColors.black87),
          enableActiveFill: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: AppSizes.length72,
            fieldWidth: AppSizes.length72,
            inactiveFillColor: AppColors.gray100,
            activeFillColor: AppColors.primaryColor50,
            selectedFillColor: AppColors.primaryColor50,
            disabledColor: AppColors.gray100,
            inactiveColor: AppColors.gray200,
            activeColor: AppColors.gray300,
            selectedColor: AppColors.primaryColor50,
            activeBorderWidth: 1,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
