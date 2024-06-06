import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/common_widgets/profile_image.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/from_validators.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:education_app/src/model/area_model.dart';
import 'package:education_app/src/model/province_model.dart';
import 'package:education_app/src/model/stage_model.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:education_app/src/model/teacher_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
import '../../common_widgets/title_form_field_widget.dart';
import '../../services/account_service.dart';

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
  final _studyStages = [];
  final _subjects = [];
  final _locationDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  StageModel? _stage;
  ProvinceModel? _province;
  AreaModel? _area;

  @override
  void initState() {
    final data = ref.read(getAccountDataProvider).value;
    _userInfo = ref.read(asyncInitProvider).localStorage.getUserInfo()!;
    debugPrint(_userInfo.accountType.name);
    if (data is StudentModel) {
      _nameController.text = data.name;
      _stage = data.stage;
      _province = data.province;
      _area = data.area;
    } else if (data is TeacherModel) {
      _nameController.text = data.name;
      _studyStages.addAll(data.stages);
      _subjects.addAll(data.subjects);
      _province = data.province!;
      _area = data.area!;
      _locationDescriptionController.text = data.locationDescription;
      _descriptionController.text = data.description;
    } else {
      data as AcademyModel;
      _nameController.text = data.title;
      _studyStages.addAll(data.stages);
      _province = data.province!;
      _area = data.area!;
      _locationDescriptionController.text = data.locationDescription;
      _descriptionController.text = data.description;
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
      debugPrint('DATA NOT VALID');
      return;
    }

    final data = ref.read(getAccountDataProvider).value;

    final T accountData;

    if (data is StudentModel) {
      accountData = StudentModel(
        phone: data.phone,
        id: _userInfo.userId,
        name: _nameController.text,
        province: _province!,
        area: _area!,
        // accountType: _userInfo.accountType,
        // description: _descriptionController.text,
        // locationDescription: _locationDescriptionController.text,
        stage: _stage!,
        // stages: _studyStages,
        // subjects: _subjects,
      ) as T;
    } else if (data is TeacherModel) {
    /*  accountData = TeacherModel(
        phone: data.phone,
        id: _userInfo.id,
        name: _nameController.text,
        province: _province!,
        area: _area!,
        // accountType: _userInfo.accountType,
        description: _descriptionController.text,
        locationDescription: _locationDescriptionController.text,
        // stage: _stage!,
        // stages: _studyStages,
        // subjects: _subjects,
      ) as T;*/
    } else {
      data as AcademyModel;
     /* accountData = AcademyModel(
        phone: data.phone,
        id: _userInfo.id,
        title: _nameController.text,
        province: _province!,
        area: _area!,
        // accountType: _userInfo.accountType,
        description: _descriptionController.text,
        locationDescription: _locationDescriptionController.text,
        // stage: _stage!,
        // stages: _studyStages,
        // subjects: _subjects,
      ) as T;*/
    }

/*    ref.read(personalProfileProvider.notifier).updateAccount(
          data: accountData,
          previous: data,
        );*/
  }

  // Future<File?> takePicture(ImageSource source, [int? imageQuality]) async {
  //   try {
  //     final imagePicker = ImagePicker();
  //     final image = await imagePicker.pickImage(
  //       source: source,
  //       imageQuality: imageQuality,
  //     );
  //     if (image == null) {
  //       return null;
  //     }
  //     return File(image.path);
  //   } catch (e) {
  //     return null;
  //   }
  // }

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
                return ProfileImage(
                  imageUrl: null,
                  imageFile: image,
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
                  press: () async {
                /*    final file = await takePicture(ImageSource.gallery);
                    ref.read(profileImageProvider.notifier).state = file;*/
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
                title: AppStrings.descriptionStr,
                hintText: AppStrings.descriptionExStr,
                controller: _descriptionController,
                validator: (val) => val.isValidDescription,
                maxLines: 3,
              ),
              gap24,
              Row(
                children: [
/*                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final val = ref.watch(stagesLengthProvider);
*//*                        return MultiSelectDialogFormField(
                          title: AppStrings.studyStagesStr,
                          confirm: (stages) {
                            if (stages.isNotEmpty) {
                              _studyStages.clear();
                              _studyStages.addAll(stages);
                              ref.read(stagesLengthProvider.notifier).state =
                                  _studyStages.length;
                            }
                          },
                          items: ref.read(getHomeDataProvider).value!.stages,
                          initialValue: _studyStages,
                          btnText: val > 0
                              ? AppStrings.selectDoneStr
                              : AppStrings.selectStagesStr,
                        );*//*
                      },
                    ),
                  ),*/
                  if (_userInfo.accountType == AccountType.TEACHER) ...[
                    gapH8,
/*                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final val = ref.watch(subjectsChangesProvider);
                          return MultiSelectDialogFormField(
                            title: AppStrings.subjectsStr,
                            confirm: (subjects) {
                              if (subjects.isNotEmpty) {
                                _subjects.clear();
                                _subjects.addAll(subjects);
                                ref
                                    .read(subjectsChangesProvider.notifier)
                                    .state = subjects.length;
                              }
                            },
                            items: ref
                                .read(getHomeDataProvider)
                                .value!
                                .subjectsNames,
                            initialValue: _subjects,
                            btnText: val > 0
                                ? AppStrings.selectDoneStr
                                : AppStrings.selectSubjectsStr,
                          );
                        },
                      ),
                    ),*/
                  ]
                ],
              ),
            ],
            if (_userInfo.accountType == AccountType.STUDENT) ...[
              gap24,
/*              DropDownFormFieldWidget(
                title: AppStrings.stageStr,
                hintText: AppStrings.stageExStr,
                onChange: (stage) => _stage = stage,
                items: ref.read(getHomeDataProvider).value!.stages,
                selectedItem: _stage,
              ),*/
            ],
            gap24,
            Row(
              children: [
/*                Expanded(
                  child: DropDownFormFieldWidget(
                    title: AppStrings.provinceStr,
                    hintText: AppStrings.selectProvinceStr,
                    onChange: (province) {
                      // to update province
                      ref
                          .read(provinceProvider.notifier)
                          .update((state) => province!);
                      _province = province;
                    },
                    items: ref.read(getHomeDataProvider).value!.provinces,
                    selectedItem: _province,
                  ),
                ),*/
                gapH8,
/*                Expanded(
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
                        selectedItem: ref.read(provinceProvider).isEmpty
                            ? _area
                            : ref
                                .read(getHomeDataProvider)
                                .value!
                                .getAreasByProvinceName(_province)[0],
                      );
                    },
                  ),
                ),*/
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
}

