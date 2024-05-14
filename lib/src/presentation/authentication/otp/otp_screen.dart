import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/presentation/authentication/otp/widgets/otp_textField.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/auth_title_desc_widget.dart';
import '../../../common_widgets/primary_elevated_btn.dart';
import '../../../core/constants/app_sizes.dart';
import '../../controllers/otp_controller.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key});

  static const routeName = '/otp_screen';

  void _submit({required WidgetRef ref, required String otp}) {
    ref.read(signInSignupControllerProvider.notifier).verifyOtp(otp);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInSignupControllerProvider.select((state) => state.value),
        (_, next) {
      if (next.isLoading) {
        EasyLoading.show();
      } else if (next.hasError) {
        EasyLoading.dismiss();
        next.showErrorDialog(context);
      } else {
        EasyLoading.dismiss();
        Navigator.popUntil(context, (route) => route.settings.name == '/');
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
                      press: () => _submit(ref: ref, otp: otp),
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
