import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/common_widgets/title_text_btn_row_widget.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/main_model.dart';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/presentation/authentication/otp/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:education_app/src/presentation/controllers/sign_in_signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/auth_title_desc_widget.dart';
import '../../common_widgets/drop_down_form_field_widget.dart';
import '../../common_widgets/mutli_select_dialog_form_field.dart';
import '../../common_widgets/primary_elevated_btn.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../../data/home_repository.dart';
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
  final _facebookPageUrlController = TextEditingController();
  final _youtubeChannelUrl = TextEditingController();
  final _nameController = TextEditingController();
  final List _studyStagesIds = [];
  final List _subjectsIds = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _stageId;
  String? _provinceId;
  String? _areaId;

  Future<void> _submitForm() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final success =
          await ref.read(signInSignupControllerProvider.notifier).requestOtp(
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                accountType: _accountType!,
                stageId: _stageId,
                description: _descriptionController.text.trim(),
                subjectsIds: _subjectsIds,
                stagesIds: _studyStagesIds,
                provinceId: _provinceId,
                areaId: _areaId,
                locationDescription: _locationDescriptionController.text.trim(),
                facebookPageUrl: _facebookPageUrlController.text.trim(),
                youtubeChannelUrl: _youtubeChannelUrl.text.trim(),
              );

      if (success) {
        EasyLoading.dismiss();
        if (context.mounted) {
          Navigator.pushNamed(context, OtpScreen.routeName);
        }
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _locationDescriptionController.dispose();
    _descriptionController.dispose();
    _facebookPageUrlController.dispose();
    _youtubeChannelUrl.dispose();
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
    final value = ref.watch(getHomeDataProvider);

    final signInSignupState = ref.read(signInSignupControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: AsyncWidget(
        value: value,
        retry: () => ref.invalidate(getHomeDataProvider),
        data: (homeData) => Column(
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
                            title: ref
                                        .read(signInSignupControllerProvider)
                                        .accountType ==
                                    AccountType.ACADEMY
                                ? AppStrings.academyNameStr
                                : AppStrings.nameStr,
                            hintText: '',
                            controller: _nameController,
                            validator: (val) => val.isValidText,
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
                        if (signInSignupState.isTeacherOrAcademyAndSignup) ...[
                          TitleFormFiledWidget(
                            title: AppStrings.descriptionStr,
                            hintText: AppStrings.descriptionExStr,
                            controller: _descriptionController,
                            validator: (val) => val.isValidDescription,
                            maxLines: 3,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.facebookPageUrlStr,
                            hintText: 'https://www.facebook.com',
                            controller: _facebookPageUrlController,
                          ),
                          gap24,
                          TitleFormFiledWidget(
                            title: AppStrings.youtubeChannelUrlStr,
                            hintText: 'http://www.youtube.com',
                            controller: _youtubeChannelUrl,
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
                        ref.read(signInSignupControllerProvider).formType ==
                                FormType.signup
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DropDownFormFieldWidget(
                                        title: AppStrings.provinceStr,
                                        hintText: AppStrings.selectProvinceStr,
                                        onChange: (id) {
                                          ref
                                              .read(provinceIdProvider.notifier)
                                              .update((state) => id!);
                                          _provinceId = id;
                                        },
                                        items: homeData.provinces),
                                  ),
                                  gapH8,
                                  Expanded(
                                    child: Consumer(
                                      builder: (context, ref, child) {
                                        ref.watch(provinceIdProvider);
                                        List<AreaModel> areas =
                                            _getAreasByProvinceId(
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
              btnText:
                  ref.read(signInSignupControllerProvider).bottomButtonText,
              press: () {
                ref
                    .read(signInSignupControllerProvider.notifier)
                    .updateFormType();
              },
            ),
            gap24,
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

  List<AreaModel> _getAreasByProvinceId({
    required List<ProvinceModel> provinces,
    required String? provinceId,
  }) {
    final List<AreaModel> areas = provinceId != null
        ? provinces
            .firstWhere(
              (p) => p.id == provinceId,
            )
            .areas
        : [];
    return areas;
  }
}
