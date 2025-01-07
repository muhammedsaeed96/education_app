import 'package:education_app/src/common_widgets/alert_dialogs.dart';
import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/profile_image.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/form_validators.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widgets/drop_down_form_field_widget.dart';
import '../common_widgets/mutli_select_dialog_form_field.dart';
import '../common_widgets/outstanding_teaching_checkbox.dart';
import '../common_widgets/teaching_on_student_home_checkbox.dart';
import '../common_widgets/title_form_field_widget.dart';
import 'controllers/account_controller.dart';

class PersonalProfileScreen extends ConsumerStatefulWidget {
  const PersonalProfileScreen({super.key});

  static const routeName = 'personal_profile_screen';

  @override
  ConsumerState<PersonalProfileScreen> createState() =>
      _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends ConsumerState<PersonalProfileScreen> {
  late final UserInfoModel _userInfo;

  final formKey = GlobalKey<FormState>();

  // final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final List<dynamic> _stagesIds = [];
  final List<dynamic> _subjectsIds = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _facebookController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _telegramController = TextEditingController();
  final _instagramController = TextEditingController();
  String? _stageId;
  String? _provinceId;
  String? _areaId;
  String? _teachingType;

  // teacher , student or academy data
  dynamic _accountData;

  bool _isFormDataUpdated = false;

  late final String? _imageUrl;

  @override
  void initState() {
    _accountData = ref.read(getAccountDataProvider(true)).value;
    _userInfo = ref.read(asyncInitProvider).localStorage.getUserInfo()!;

    _provinceId = _accountData.provinceId;
    _imageUrl = _accountData.imageUrl;

    if (_accountData is StudentModel) {
      _nameController.text = _accountData.name;
      _stageId = _accountData.stageId;
    } else if (_accountData is TeacherModel) {
      _nameController.text = _accountData.name;
      _areaId = _accountData.areaId;
      _stagesIds.addAll(_accountData.stagesIds);
      _subjectsIds.addAll(_accountData.subjectsIds);
      _locationDescriptionController.text = _accountData.locationDescription;
      _descriptionController.text = _accountData.description;
      _facebookController.text = _accountData.facebookUrl ?? '';
      _youtubeController.text = _accountData.youtubeUrl ?? '';
      _telegramController.text = _accountData.telegramUrl ?? '';
      _instagramController.text = _accountData.instagramUrl ?? '';
      _teachingType =
          TeacherModel.getTeacherTeachingTypeKey(_accountData.teachingType);
    } else {
      _accountData as AcademyModel;
      _nameController.text = _accountData.title;
      _areaId = _accountData.areaId;
      _stagesIds.addAll(_accountData.stagesIds);
      _locationDescriptionController.text = _accountData.locationDescription;
      _descriptionController.text = _accountData.description;
      _facebookController.text = _accountData.facebookUrl ?? '';
      _youtubeController.text = _accountData.youtubeUrl ?? '';
      _telegramController.text = _accountData.telegramUrl ?? '';
      _instagramController.text = _accountData.instagramUrl ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationDescriptionController.dispose();
    _descriptionController.dispose();
    _facebookController.dispose();
    _youtubeController.dispose();
    _instagramController.dispose();
    _telegramController.dispose();
    super.dispose();
  }

  void _submitForm<T>() {
    if (!formKey.currentState!.validate()) {
      debugPrint('AccountData NOT VALID');
      return;
    }

    final T formData;

    if (_accountData is StudentModel) {
      formData = StudentModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        name: _nameController.text,
        provinceId: _provinceId!,
        stageId: _stageId!,
      ) as T;
    } else if (_accountData is TeacherModel) {
      formData = TeacherModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        name: _nameController.text.trim(),
        provinceId: _provinceId,
        areaId: _areaId,
        description: _descriptionController.text.trim(),
        locationDescription: _locationDescriptionController.text.trim(),
        stagesIds: _stagesIds.cast<String>(),
        subjectsIds: _subjectsIds.cast<String>(),
        facebookUrl: _facebookController.text.trim(),
        youtubeUrl: _youtubeController.text.trim(),
        telegramUrl: _telegramController.text.trim(),
        instagramUrl: _instagramController.text.trim(),
        teachingType: TeacherModel.getTeacherTeachingTypeVal(_teachingType!),
        outstandingTeaching: ref.read(isTeacherTeachingOutstanding),
        teachingOnStudentHome: ref.read(isTeacherTeachingOnStudentHome),
      ) as T;
    } else {
      _accountData as AcademyModel;
      formData = AcademyModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        title: _nameController.text.trim(),
        provinceId: _provinceId,
        areaId: _areaId,
        description: _descriptionController.text.trim(),
        locationDescription: _locationDescriptionController.text.trim(),
        stagesIds: _stagesIds.cast<String>(),
        facebookUrl: _facebookController.text.trim(),
        youtubeUrl: _youtubeController.text.trim(),
        telegramUrl: _telegramController.text.trim(),
        instagramUrl: _instagramController.text.trim(),
      ) as T;
    }

    // if user not changed his account data then i will never late him update his account
    if (_accountData == formData) {
      showAlertDialog(
        context: context,
        title: AppStrings.notifyStr,
        content: AppStrings.accountUpdateMessageStr,
      );
      return;
    }

    _accountData = _accountData.copyWithNewAccountData(formData);

    ref.read(accountControllerProvider.notifier).updateAccount(
          data: formData,
          accountType: _userInfo.accountType.name,
          id: _userInfo.userId,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(accountControllerProvider, (previous, next) {
      if (!next.hasError && !next.isLoading) {
        _isFormDataUpdated = true;
        showSuccessAlertDialog(context: context);
      }
    });

    return PopScope(
      onPopInvoked: (canPop) {
        // if user updated i will fetch account data again to update previous screen
        if (_isFormDataUpdated) {
          ref.invalidate(getAccountDataProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.accountInfoStr)),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final image = ref.watch(profileImageProvider);
                  return Center(
                    child: ProfileImage(
                      imageUrl: _imageUrl.getFullUrl,
                      imageFile: image,
                    ),
                  );
                },
              ),
              gap8,
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.length148 / 2),
                  child: PrimaryElevatedBtn(
                    height: AppSizes.length40,
                    width: AppSizes.length148,
                    text: AppStrings.changeImageStr,
                    press: () {
                      ref.read(profileImageProvider.notifier).state = null;
                      Navigator.pushNamed(
                        context,
                        SelectProfilePictureScreen.routeName,
                        arguments: _accountData.imageUrl.toString().getFullUrl,
                      );
                    },
                  ),
                ),
              ),
              gap32,
              TitleFormFiledWidget(
                title: AppStrings.nameStr,
                hintText: AppStrings.nameExStr,
                controller: _nameController,
                validator: (val) => val.isValidText,
              ),
              if (_userInfo.accountType != AccountType.STUDENT) ...[
                gap24,
                TitleFormFiledWidget(
                  title: _userInfo.accountType == AccountType.ACADEMY
                      ? AppStrings.aboutAcademyStr
                      : AppStrings.aboutYouStr,
                  hintText: AppStrings.descriptionExStr,
                  controller: _descriptionController,
                  validator: (val) => val.isValidDescription,
                  maxLines: 4,
                ),
                gap24,
              ],
              if (_userInfo.accountType == AccountType.STUDENT) ...[
                DropDownFormFieldWidget(
                  title: AppStrings.stageStr,
                  hintText: AppStrings.stageExStr,
                  onChange: (stageId) => _stageId = stageId,
                  items: _accountData.stages,
                  selectedItem: _stageId!,
                ),
              ],
              gap24,
              if (_userInfo.accountType != AccountType.STUDENT) ...[
                _userInfo.accountType == AccountType.TEACHER
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildStagesMultiSelectDialogFromField(),
                          ),
                          gapH8,
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final val =
                                    ref.watch(subjectsIdsChangesProvider);
                                return MultiSelectDialogFormField(
                                  title: AppStrings.subjectsStr,
                                  confirm: (ids) {
                                    final controller = ref.read(
                                      subjectsIdsChangesProvider.notifier,
                                    );
                                    controller.state = 0;
                                    _subjectsIds.clear();
                                    if (ids.isNotEmpty) {
                                      _subjectsIds.addAll(ids);
                                      controller.state = ids.length;
                                    }
                                  },
                                  initialValue: _accountData.subjectsIds,
                                  items: _accountData.allSubjects,
                                  btnText: val > 0
                                      ? AppStrings.selectDoneStr
                                      : AppStrings.selectSubjectsStr,
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : _buildStagesMultiSelectDialogFromField(),
                gap24,
              ],
              if (_userInfo.accountType == AccountType.TEACHER) ...[
                DropDownFormFieldWidget(
                  title: AppStrings.teachingTypeStr,
                  hintText: AppStrings.teachingTypeStr,
                  selectedItem: _teachingType,
                  onChange: (val) => _teachingType = val,
                  items: TeacherModel.teacherTeachingTypesMap.keys.toList(),
                ),
                gap24,
              ],
              _buildProvinceArea(),
              if (_userInfo.accountType != AccountType.STUDENT) ...[
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
                if (_userInfo.accountType == AccountType.TEACHER) ...[
                  gap4,
                  OutstandingTeachingCheckbox(),
                  TeachingOnStudentHomeCheckbox(),
                ]
              ],
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 40,
            right: 16,
            left: 16,
          ),
          child: PrimaryElevatedBtn(
            press: _submitForm,
            text: AppStrings.editStr,
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceArea() {
    final provinceWidget = DropDownFormFieldWidget(
      title: AppStrings.provinceStr,
      hintText: AppStrings.selectProvinceStr,
      onChange: (provinceId) {
        _areaId = null;
        // to update province
        _provinceId = provinceId;
        ref.read(provinceIdProvider.notifier).update((state) => provinceId!);
      },
      items: _accountData.provinces,
      selectedItem: _provinceId!,
    );

    final areaWidget = Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(provinceIdProvider);
          List<AreaModel> areas = AreaModel.getAreasByProvinceId(
            provinces: _accountData.provinces,
            provinceId: _provinceId,
          );
          if (areas.isNotEmpty && _areaId == null) {
            _areaId = areas[0].id;
          }
          return DropDownFormFieldWidget(
            title: AppStrings.areaStr,
            hintText: AppStrings.selectAreaStr,
            onChange: (id) => _areaId = id,
            items: areas,
            selectedItem: _areaId,
            needSetSelectedItem: true,
          );
        },
      ),
    );

    if (_userInfo.accountType != AccountType.STUDENT) {
      return Row(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(132),
            child: provinceWidget,
          ),
          gapH8,
          areaWidget
        ],
      );
    }
    return provinceWidget;
  }

  Widget _buildStagesMultiSelectDialogFromField() {
    return Consumer(
      builder: (context, ref, child) {
        final val = ref.watch(stagesLengthProvider);
        return MultiSelectDialogFormField(
          title: AppStrings.studyStagesStr,
          confirm: (ids) {
            final controller = ref.read(stagesLengthProvider.notifier);
            controller.state = 0;
            _stagesIds.clear();
            if (ids.isNotEmpty) {
              _stagesIds.addAll(ids);
              controller.state = ids.length;
            }
          },
          initialValue: _accountData.stagesIds,
          items: _accountData.allStages,
          btnText:
              val > 0 ? AppStrings.selectDoneStr : AppStrings.selectStagesStr,
        );
      },
    );
  }
}
