import 'package:education_app/src/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:education_app/src/core/utils/form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/enum.dart';
import '../controllers/sign_in_signup_controller.dart';
import 'otp_screen.dart';

class EnterPhoneScreen extends ConsumerStatefulWidget {
  const EnterPhoneScreen({super.key});

  static const routeName = 'enter_phone_screen';

  @override
  ConsumerState<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends ConsumerState<EnterPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final isSuccess = await ref
          .read(signInSignupControllerProvider.notifier)
          .requestOtp(
            phone: _phoneController.text.trim().getFullPhone,
            accountType: ref.read(signInSignupControllerProvider).accountType,
          );

      if (mounted && isSuccess) {
        Navigator.pushNamed(context, OtpScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Text(_getAppBarTitleByAccountType),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 36,
            bottom: 16,
          ),
          child: Column(
            children: [
              const AuthTitleDescWidget(
                title: AppStrings.enterPhoneNumber,
                description: AppStrings.enterPhoneDescNumber,
              ),
              gap24,
              Form(
                key: _formKey,
                child: TitleFormFiledWidget(
                  title: AppStrings.phoneStr,
                  hintText: '07717665121',
                  controller: _phoneController,
                  validator: (val) => val.isValidPhone,
                  isPhone: true,
                ),
              ),
              gap24,
              PrimaryElevatedBtn(
                press: _submitForm,
                text: AppStrings.sendOnWhatsAppStr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _getAppBarTitleByAccountType {
    final type = ref.read(signInSignupControllerProvider).accountType;

    if (type == AccountType.TEACHER) {
      return AppStrings.createTeacherAccountStr;
    } else if (type == AccountType.ACADEMY) {
      return AppStrings.createAcademyAccountStr;
    } else {
      return AppStrings.createStudentAccountStr;
    }
  }
}
