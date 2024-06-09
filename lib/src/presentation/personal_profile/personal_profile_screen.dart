import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/profile_image.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/core/utils/string_extension.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/drop_down_form_field_widget.dart';
import '../../common_widgets/mutli_select_dialog_form_field.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../../data/home_repository.dart';
import '../controllers/account_controller.dart';

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
  final List<String> _stagesIds = [];
  final List<String> _subjectsIds = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  StageModel? _stage;
  String? _provinceId;
  String? _areaId;

  // teacher , student or academy data
  late final dynamic _accountData;

  @override
  void initState() {
    _accountData = ref.read(getAccountDataProvider(true)).value;
    _userInfo = ref.read(asyncInitProvider).localStorage.getUserInfo()!;

    if (_accountData is StudentModel) {
      _nameController.text = _accountData.name;
      _stage = _accountData.stage;
      _provinceId = _accountData.provinceId;
      _areaId = _accountData.provinceId;
    } else if (_accountData is TeacherModel) {
      _nameController.text = _accountData.name;
      _stagesIds.addAll(_accountData.stagesIds);
      _subjectsIds.addAll(_accountData.subjectsIds);
      _provinceId = _accountData.provinceId;
      _areaId = _accountData.areaId;
      _locationDescriptionController.text = _accountData.locationDescription;
      _descriptionController.text = _accountData.description;
    } else {
      _accountData as AcademyModel;
      _nameController.text = _accountData.title;
      _stagesIds.addAll(_accountData.stagesIds);
      // _provinceId = _accountData.provinceId;
      // _areaId = _accountData.areaId;
      _locationDescriptionController.text = _accountData.locationDescription;
      _descriptionController.text = _accountData.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationDescriptionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm<T>() {

    if (!formKey.currentState!.validate()) {
      debugPrint('AccountData NOT VALID');
      return;
    }

    final T accountData;

    if (_accountData is StudentModel) {
      accountData = StudentModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        name: _nameController.text,
        provinceId: _provinceId!,
        areaId: _areaId!,
        stage: _stage!,
      ) as T;
    } else if (_accountData is TeacherModel) {
      accountData = TeacherModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        name: _nameController.text,
        provinceId: _provinceId,
        areaId: _areaId,
        description: _descriptionController.text,
        locationDescription: _locationDescriptionController.text,
        stagesIds: _stagesIds,
        subjectsIds: _subjectsIds,
      ) as T;
    } else {
      _accountData as AcademyModel;
      accountData = AcademyModel(
        phone: _accountData.phone,
        id: _userInfo.userId,
        title: _nameController.text,
        // province: _province!,
        // area: _area!,
        // accountType: _userInfo.accountType,
        description: _descriptionController.text,
        locationDescription: _locationDescriptionController.text,
        // stage: _stage!,
        // stages: _studyStages,
        // subjects: _subjects,
      ) as T;
    }

    ref.read(accountControllerProvider.notifier).updateAccount(
          data: accountData,
          accountType: _userInfo.accountType.name,
          id: _userInfo.userId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    imageUrl: _accountData.imageUrl.toString().getFullUrl,
                    imageFile: image,
                  ),
                );
              },
            ),
            gap8,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.length132 / 2),
                child: PrimaryElevatedBtn(
                  height: AppSizes.length40,
                  width: AppSizes.length144,
                  text: AppStrings.changeImageStr,
                  press: () => Navigator.pushNamed(
                    context,
                    SelectProfilePictureScreen.routeName,
                    arguments: _accountData.imageUrl.toString().getFullUrl,
                  ),
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
                title: AppStrings.descriptionStr,
                hintText: AppStrings.descriptionExStr,
                controller: _descriptionController,
                validator: (val) => val.isValidDescription,
                maxLines: 3,
              ),
              gap24,
            ],
            if (_userInfo.accountType == AccountType.STUDENT) ...[
              gap24,
              DropDownFormFieldWidget(
                title: AppStrings.stageStr,
                hintText: AppStrings.stageExStr,
                onChange: (stage) => _stage = stage,
                items: ref.read(getHomeDataProvider).value!.stages,
                selectedItem: _stage!.id,
              ),
            ],
            gap24,
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
                            final val = ref.watch(subjectsIdsChangesProvider);
                            return MultiSelectDialogFormField(
                              title: AppStrings.subjectsStr,
                              confirm: (ids) {
                                final controller = ref
                                    .read(subjectsIdsChangesProvider.notifier);
                                controller.state = 0;
                                _subjectsIds.clear();
                                if (ids.isNotEmpty) {
                                  _subjectsIds.addAll(ids as Iterable<String>);
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
            Row(
              children: [
                Expanded(
                  child: DropDownFormFieldWidget(
                    title: AppStrings.provinceStr,
                    hintText: AppStrings.selectProvinceStr,
                    onChange: (province) {
                      // to update province
                      ref
                          .read(provinceIdProvider.notifier)
                          .update((state) => province!);
                      _provinceId = province;
                    },
                    items: _accountData.provinces,
                    selectedItem: _provinceId!,
                  ),
                ),
                gapH8,
                Expanded(
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
                ),
              ],
            ),
            if (_userInfo.accountType != AccountType.STUDENT) ...[
              gap24,
              TitleFormFiledWidget(
                title: AppStrings.locationDescriptionStr,
                hintText: AppStrings.locationDescExStr,
                controller: _locationDescriptionController,
                validator: (val) => val.isValidDescription,
                maxLines: 3,
              ),
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
    );
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
              _stagesIds.addAll(ids as Iterable<String>);
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
