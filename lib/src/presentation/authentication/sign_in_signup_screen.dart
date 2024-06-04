/*
import 'package:education_app/src/common_widgets/title_text_btn_row_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/presentation/authentication/otp/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/home_service.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/drop_down_form_field_widget.dart';
import '../../common_widgets/mutli_select_dialog_form_field.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../controllers/sample_state_controller.dart';

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
  final _nameController = TextEditingController();
  final List _studyStages = [];
  final List _subjects = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _stage;
  String? _province;
  String? _area;

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      final success =
          await ref.read(signInSignupControllerProvider.notifier).requestOtp(
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                accountType: _accountType!,
                stage: _stage,
                description: _descriptionController.text.trim(),
                subjects: _subjects,
                stages: _studyStages,
                province: _province,
                area: _area,
                locationDescription: _locationDescriptionController.text.trim(),
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
            title: ref.read(signInSignupControllerProvider).topTitleText,
            description:
                ref.read(signInSignupControllerProvider).topDescriptionText,
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
                      if (ref.read(signInSignupControllerProvider).formType ==
                          FormType.signup) ...[
                        gap24,
                        TitleFormFiledWidget(
                          title: ref.read(signInSignupControllerProvider).accountType == AccountType.academy
                              ? AppStrings.academyNameStr
                              : AppStrings.nameStr,
                          hintText: '',
                          controller: _nameController,
                          validator: (val) => val.isValidText,
                          isPhone: true,
                        ),
                      ],
                      gap24,
                      TitleFormFiledWidget(
                        title: AppStrings.phoneStr,
                        hintText: '07717665121',
                        controller: _phoneController,
                        validator: (val) => val.isValidPhone,
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
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final val = ref.watch(stagesLengthProvider);
                                  return MultiSelectDialogFormField(
                                    title: AppStrings.studyStagesStr,
                                    confirm: (stages) {
                                      if (stages.isNotEmpty) {
                                        _studyStages.clear();
                                        _studyStages.addAll(stages);
                                        ref
                                            .read(stagesLengthProvider.notifier)
                                            .state = _studyStages.length;
                                      }
                                    },
                                    items: ref
                                        .read(getHomeDataProvider)
                                        .value!
                                        .stages,
                                    btnText: val > 0
                                        ? AppStrings.selectDoneStr
                                        : AppStrings.selectStagesStr,
                                  );
                                },
                              ),
                            ),
                            gapH8,
                            Expanded(
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final val =
                                      ref.watch(subjectsChangesProvider);
                                  return MultiSelectDialogFormField(
                                    title: AppStrings.subjectsStr,
                                    confirm: (subjects) {
                                      if (subjects.isNotEmpty) {
                                        _subjects.clear();
                                        _subjects.addAll(subjects);
                                        ref
                                            .read(subjectsChangesProvider
                                                .notifier)
                                            .state = subjects.length;
                                      }
                                    },
                                    items: ref
                                        .read(getHomeDataProvider)
                                        .value!
                                        .subjectsNames,
                                    btnText: val > 0
                                        ? AppStrings.selectDoneStr
                                        : AppStrings.selectSubjectsStr,
                                  );
                                },
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
                          items: ref.read(getHomeDataProvider).value!.stages,
                        ),
                        gap24,
                      ],

                      // to show these row if form type is signup
                      ref.read(signInSignupControllerProvider).formType ==
                              FormType.signup
                          ? Row(
                              children: [
                                Expanded(
                                  child: DropDownFormFieldWidget(
                                    title: AppStrings.provinceStr,
                                    hintText: AppStrings.selectProvinceStr,
                                    onChange: (province) {
                                      ref
                                          .read(provinceProvider.notifier)
                                          .update((state) => province!);
                                      _province = province;
                                    },
                                    items: ref
                                        .read(getHomeDataProvider)
                                        .value!
                                        .provinces,
                                  ),
                                ),
                                gapH8,
                                Expanded(
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      ref.watch(provinceProvider);
                                      return DropDownFormFieldWidget(
                                        title: AppStrings.areaStr,
                                        hintText: AppStrings.selectAreaStr,
                                        onChange: (area) => _area = area,
                                        items: ref
                                            .read(getHomeDataProvider)
                                            .value!
                                            .getAreasByProvinceName(_province),
                                      );
                                    },
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
            title: ref.read(signInSignupControllerProvider).bottomTitleText,
            btnText: ref.read(signInSignupControllerProvider).bottomButtonText,
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
*/
