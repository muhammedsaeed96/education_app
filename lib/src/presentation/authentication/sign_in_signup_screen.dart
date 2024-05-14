import 'package:education_app/src/common_widgets/title_text_btn_row_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/presentation/authentication/otp/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/drop_down_form_field_widget.dart';
import '../../common_widgets/mutli_select_dialog_form_field.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../common_widgets/title_form_field_widget.dart';

class SignInSignupScreen extends ConsumerStatefulWidget {
  static const routeName = 'signIn_signup_screen';

  const SignInSignupScreen({super.key});

  @override
  ConsumerState<SignInSignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignInSignupScreen> {
  final formKey = GlobalKey<FormState>();

  String? _accountType;
  final _phoneController = TextEditingController();
  final List<String> _studyStages = [];
  final List<String> _subjects = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _stage;
  String? _province;
  String? _area;

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      final success =
      await ref.read(signInSignupControllerProvider.notifier).requestOtp(
        phone: _phoneController.text,
        accountType: _accountType!,
        stage: _stage,
        description: _descriptionController.text,
        subjects: _subjects,
        stages: _studyStages,
        province: _province,
        area: _area,
        locationDescription: _locationDescriptionController.text,
      );

      if (success) {
        EasyLoading.dismiss();
        Navigator.pushNamed(context, OtpScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _locationDescriptionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInSignupControllerProvider.select((state) => state.value),
            (_, next) {
          if (next.isLoading) {
            EasyLoading.show();
          } else if (next.hasError) {
            EasyLoading.dismiss();
            next.showErrorDialog(context);
          }
        });

    ref.watch(signInSignupControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          gap16,
          AuthTitleDescWidget(
            title: ref
                .read(signInSignupControllerProvider)
                .topTitleText,
            description:
            ref
                .read(signInSignupControllerProvider)
                .topDescriptionText,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DropDownFormFieldWidget(
                        title: AppStrings.accountTypeStr,
                        hintText: AppStrings.selectRegistrationTypeStr,
                        onChange: (accountType) {
                          _accountType = accountType;
                          ref
                              .read(signInSignupControllerProvider.notifier)
                              .updateRegistrationType(accountType!);
                        },
                        items: AppStrings.accountTypes,
                      ),
                      gap24,
                      TitleFormFiledWidget(
                        title: AppStrings.phoneStr,
                        hintText: '07717665121',
                        controller: _phoneController,
                        validator: (val) => null,
                        isPhone: true,
                      ),
                      gap24,
                      // to show these widgets if account type not student
                      if (ref
                          .read(signInSignupControllerProvider)
                          .isTeacherOrAcademyAndSignup) ...[
                        TitleFormFiledWidget(
                          title: AppStrings.descriptionStr,
                          hintText: AppStrings.descriptionExStr,
                          controller: _descriptionController,
                          validator: (val) => val.isValidDescription,
                          maxLines: 3,
                        ),
                        gap24,
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogFormField(
                                title: AppStrings.studyStagesStr,
                                confirm: (stages) {
                                  if (stages != null && stages.isNotEmpty) {
                                    _studyStages.clear();
                                    _studyStages.addAll(stages as List<String>);
                                  }
                                },
                                items: AppStrings.studyStagesListStr,
                              ),
                            ),
                            gapH8,
                            Expanded(
                              child: MultiSelectDialogFormField(
                                title: AppStrings.subjectsStr,
                                confirm: (subjects) {
                                  if (subjects != null && subjects.isNotEmpty) {
                                    _subjects.clear();
                                    _subjects.addAll(subjects as List<String>);
                                  }
                                },
                                items: AppStrings.subjectsListStr,
                              ),
                            ),
                          ],
                        ),
                        gap24,
                      ],

                      if (ref
                          .read(signInSignupControllerProvider)
                          .isStudentAndSignup) ...[
                        DropDownFormFieldWidget(
                          title: AppStrings.stageStr,
                          hintText: AppStrings.stageExStr,
                          onChange: (stage) => _stage = stage,
                          items: AppStrings.studyStagesListStr,
                        ),
                        gap24,
                      ],

                      // to show these row if form type is signup
                      ref
                          .read(signInSignupControllerProvider)
                          .formType ==
                          FormType.signup
                          ? Row(
                        children: [
                          Expanded(
                            child: DropDownFormFieldWidget(
                              title: AppStrings.cityStr,
                              hintText: AppStrings.selectProvinceStr,
                              onChange: (province) =>
                              _province = province,
                              items: AppStrings.accountTypes,
                            ),
                          ),
                          gapH8,
                          Expanded(
                            child: DropDownFormFieldWidget(
                              title: AppStrings.countryStr,
                              hintText: AppStrings.selectAreaStr,
                              onChange: (area) => _area = area,
                              items: AppStrings.accountTypes,
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),

                      if (ref
                          .read(signInSignupControllerProvider)
                          .isTeacherOrAcademyAndSignup) ...[
                        gap24,
                        TitleFormFiledWidget(
                          title: AppStrings.locationDescriptionStr,
                          hintText: AppStrings.locationDescExStr,
                          controller: _locationDescriptionController,
                          validator: (val) => val.isValidDescription,
                          maxLines: 3,
                        ),
                      ],

                      gap32,
                      PrimaryElevatedBtn(
                        press: _submitForm,
                        text: AppStrings.nextStr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TitleTextBtnRowWidget(
            title: ref
                .read(signInSignupControllerProvider)
                .bottomTitleText,
            btnText: ref
                .read(signInSignupControllerProvider)
                .bottomButtonText,
            press: () {
              ref
                  .read(signInSignupControllerProvider.notifier)
                  .updateFormType();
            },
          ),
          gap24,
        ],
      ),
    );
  }
}
