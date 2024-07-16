import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/title_text_btn_row_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/main_model.dart';
import 'package:education_app/src/presentation/authentication/enter_phone_screen.dart';
import 'package:education_app/src/presentation/authentication/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/drop_down_form_field_widget.dart';
import '../../common_widgets/mutli_select_dialog_form_field.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../../data/home_repository.dart';
import '../controllers/simple_state_controller.dart';

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
  final List _studyStagesIds = [];
  final List _subjectsIds = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _facebookController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _telegramController = TextEditingController();
  final _instagramController = TextEditingController();
  String? _stageId;
  String? _provinceId;
  String? _areaId;

  Future<void> _submitForm() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final controller = ref.read(signInSignupControllerProvider.notifier);
      final signInSingUpState = ref.read(signInSignupControllerProvider);

      // if form type is sign in i will execute request otp
      if (signInSingUpState.formType == FormType.signIn) {
        final isSuccess = await controller.requestOtp(
          phone: _phoneController.text.trim().getFullPhone,
          accountType: ref.read(signInSignupControllerProvider).accountType,
        );

        if (mounted && isSuccess) {
          Navigator.pushNamed(context, OtpScreen.routeName);
        }
      } else {
        // to copy current signup data until user enter his phone
        controller.saveSignupData(
          name: _nameController.text.trim(),
          accountType: _accountType!,
          stageId: _stageId,
          provinceId: _provinceId,
          areaId: _areaId,
          stagesIds: _studyStagesIds,
          subjectsIds: _subjectsIds,
          locationDescription: _locationDescriptionController.text.trim(),
          description: _descriptionController.text.trim(),
          facebookUrl: _facebookController.text.trim(),
          youtubeUrl: _youtubeController.text.trim(),
          telegramUrl: _telegramController.text.trim(),
          instagramUrl: _instagramController.text.trim(),
        );
        Navigator.pushNamed(context, EnterPhoneScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationDescriptionController.dispose();
    _descriptionController.dispose();
    _facebookController.dispose();
    _youtubeController.dispose();
    _instagramController.dispose();
    _telegramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInSignupControllerProvider.select((state) => state.value),
        (prev, next) {
      if (next.isLoading) {
        EasyLoading.show();
      } else if (next.hasError) {
        EasyLoading.dismiss();
        next.showErrorDialog(context);
      } else {
        EasyLoading.dismiss();
      }
    });

    final controller = ref.read(signInSignupControllerProvider);

    final signInSignupState = ref.watch(signInSignupControllerProvider);
    final value = ref.watch(getHomeDataProvider);

    return Scaffold(
      appBar: AppBar(),
      body: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getHomeDataProvider),
        data: (homeData) => Column(
          children: [
            gap16,
            AuthTitleDescWidget(
              title: controller.topTitleText,
              description: controller.topDescriptionText,
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
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
                        if (signInSignupState.formType == FormType.signup) ...[
                          gap24,
                          TitleFormFiledWidget(
                            title: ref
                                        .read(signInSignupControllerProvider)
                                        .accountType ==
                                    AccountType.ACADEMY
                                ? AppStrings.academyNameStr
                                : AppStrings.nameStr,
                            hintText: AppStrings.nameExStr,
                            controller: _nameController,
                            validator: (val) => val.isValidText,
                          ),
                        ],

                        if (signInSignupState.formType == FormType.signIn) ...[
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.phoneStr,
                            hintText: '07717665121',
                            controller: _phoneController,
                            validator: (val) => val.isValidPhone,
                            isPhone: true,
                          ),
                        ],
                        gap24,
                        // to show these widgets if account type not student
                        if (signInSignupState.isTeacherOrAcademyAndSignup) ...[
                          TitleFormFiledWidget(
                            title: signInSignupState.accountType ==
                                    AccountType.ACADEMY
                                ? AppStrings.aboutAcademyStr
                                : AppStrings.aboutYouStr,
                            hintText: AppStrings.descriptionExStr,
                            controller: _descriptionController,
                            validator: (val) => val.isValidDescription,
                            maxLines: 4,
                          ),
                          gap24,
                          signInSignupState.accountType == AccountType.TEACHER
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child:
                                          _buildStagesMultiSelectDialogFromField(
                                        homeData,
                                      ),
                                    ),
                                    gapH8,
                                    Expanded(
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final val = ref.watch(
                                              subjectsIdsChangesProvider);
                                          return MultiSelectDialogFormField(
                                            title: AppStrings.subjectsStr,
                                            confirm: (ids) {
                                              final controller = ref.read(
                                                  subjectsIdsChangesProvider
                                                      .notifier);
                                              controller.state = 0;
                                              _subjectsIds.clear();
                                              if (ids.isNotEmpty) {
                                                _subjectsIds.addAll(ids);
                                                controller.state = ids.length;
                                              }
                                            },
                                            items: homeData.subjects,
                                            btnText: val > 0
                                                ? AppStrings.selectDoneStr
                                                : AppStrings.selectSubjectsStr,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : _buildStagesMultiSelectDialogFromField(
                                  homeData,
                                ),
                          gap24,
                        ],

                        if (signInSignupState.isStudentAndSignup) ...[
                          DropDownFormFieldWidget(
                            title: AppStrings.stageStr,
                            hintText: AppStrings.stageExStr,
                            onChange: (stageId) => _stageId = stageId,
                            items: homeData.stages,
                          ),
                          gap24,
                        ],

                        // to show these row if form type is signup
                        controller.formType == FormType.signup
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: getProportionateScreenWidth(132),
                                    child: DropDownFormFieldWidget(
                                      title: AppStrings.provinceStr,
                                      hintText: AppStrings.selectProvinceStr,
                                      onChange: (id) {
                                        ref
                                            .read(provinceIdProvider.notifier)
                                            .update((state) => id!);
                                        _provinceId = id;
                                      },
                                      items: homeData.provinces,
                                    ),
                                  ),
                                  gapH8,
                                  Expanded(
                                    child: Consumer(
                                      builder: (context, ref, child) {
                                        ref.watch(provinceIdProvider);
                                        List<AreaModel> areas =
                                            AreaModel.getAreasByProvinceId(
                                          provinces: homeData.provinces,
                                          provinceId: _provinceId,
                                        );
                                        if (areas.isNotEmpty &&
                                            _areaId == null) {
                                          _areaId = areas[0].id;
                                        }
                                        return DropDownFormFieldWidget(
                                          title: AppStrings.areaStr,
                                          hintText: AppStrings.selectAreaStr,
                                          onChange: (id) => _areaId = id,
                                          items: areas,
                                          needSetSelectedItem: true,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),

                        if (signInSignupState.isTeacherOrAcademyAndSignup) ...[
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.locationDescriptionStr,
                            hintText: AppStrings.locationDescExStr,
                            controller: _locationDescriptionController,
                            validator: (val) => val.isValidDescription,
                            maxLines: 3,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.facebookPageUrlStr,
                            hintText: AppStrings.urlExStr,
                            controller: _facebookController,
                            validator: (val) => val.isValidUrl,
                            isRequired: false,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.instagramUrlStr,
                            hintText: AppStrings.urlExStr,
                            controller: _instagramController,
                            validator: (val) => val.isValidUrl,
                            isRequired: false,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.youtubeChannelUrlStr,
                            hintText: AppStrings.urlExStr,
                            controller: _youtubeController,
                            validator: (val) => val.isValidUrl,
                            isRequired: false,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.telegramChannelUrl,
                            hintText: AppStrings.urlExStr,
                            controller: _telegramController,
                            validator: (val) => val.isValidUrl,
                            isRequired: false,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryElevatedBtn(
                press: _submitForm,
                text: signInSignupState.isSignIn
                    ? AppStrings.sendOnWhatsAppStr
                    : AppStrings.nextStr,
              ),
            ),
            gap16,
            TitleTextBtnRowWidget(
              title: controller.bottomTitleText,
              btnText: controller.bottomButtonText,
              press: () {
                ref
                    .read(signInSignupControllerProvider.notifier)
                    .updateFormType();
                _clearControllers();
              },
            ),
            gap32,
          ],
        ),
      ),
    );
  }

  Widget _buildStagesMultiSelectDialogFromField(MainModel homeData) {
    return Consumer(
      builder: (context, ref, child) {
        final val = ref.watch(stagesLengthProvider);
        return MultiSelectDialogFormField(
          title: AppStrings.studyStagesStr,
          confirm: (ids) {
            final controller = ref.read(stagesLengthProvider.notifier);
            controller.state = 0;
            _studyStagesIds.clear();
            if (ids.isNotEmpty) {
              _studyStagesIds.addAll(ids);
              controller.state = ids.length;
            }
          },
          items: homeData.stages,
          btnText:
              val > 0 ? AppStrings.selectDoneStr : AppStrings.selectStagesStr,
        );
      },
    );
  }


  _clearControllers() {
    _nameController.clear();
    _phoneController.clear();
    _descriptionController.clear();
    _locationDescriptionController.clear();
    _facebookController.clear();
    _instagramController.clear();
    _youtubeController.clear();
    _telegramController.clear();
    _provinceId = null;
    _areaId = null;
    _stageId = null;
    _subjectsIds.clear();
    _studyStagesIds.clear();
  }
}
