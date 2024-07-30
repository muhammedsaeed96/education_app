import 'dart:io';
import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/presentation/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../common_widgets/bs_take_picture.dart';
import '../common_widgets/primary_elevated_btn.dart';
import '../common_widgets/profile_image.dart';
import '../core/constants/app_sizes.dart';
import 'controllers/simple_state_controller.dart';

class SelectProfilePictureScreen extends ConsumerWidget {
  const SelectProfilePictureScreen({super.key});

  static const routeName = 'select_profile_picture_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* ref.listen(accountControllerProvider, (_, next) {
      if (next.isLoading) {
        EasyLoading.show();
      } else if (next.hasError) {
        EasyLoading.dismiss();
        next.showErrorDialog(context);
      } else {
        Navigator.pop(context);
        EasyLoading.dismiss();
      }
    });*/

    ref.watch(profileImageProvider);

    final selectedImage = ref.read(profileImageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.chooseProfilePicStr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: Column(
          children: [
            ProfileImage(
              imageUrl: ModalRoute.of(context)?.settings.arguments as String?,
              imageFile: selectedImage,
            ),
            gap8,
            PrimaryElevatedBtn(
              text: selectedImage == null
                  ? AppStrings.selectPicStr
                  : AppStrings.changeImageStr,
              press: () => bsTakePicture(
                context: context,
                cameraPress: () => takePicture(
                  context: context,
                  source: ImageSource.camera,
                  ref: ref,
                ),
                galleryPress: () => takePicture(
                  context: context,
                  source: ImageSource.gallery,
                  ref: ref,
                ),
              ),
              width: getProportionateScreenWidth(140),
              radius: 20,
              height: 40,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: PrimaryElevatedBtn(
                    text: AppStrings.skipStr,
                    press: () => Navigator.pop(context),
                    width: AppSizes.length180,
                    background: AppColors.gray200,
                    textColor: AppColors.gray600,
                  ),
                ),
                gapH16,
                Expanded(
                  child: PrimaryElevatedBtn(
                    text: AppStrings.saveStr,
                    press: () => ref
                        .read(accountControllerProvider.notifier)
                        .uploadProfileImage(
                          context: context,
                          file: selectedImage!,
                        ),
                    width: AppSizes.length180,
                    disable: selectedImage == null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> takePicture({
    required BuildContext context,
    required ImageSource source,
    int imageQuality = 40,
    required WidgetRef ref,
  }) async {
    try {
      final imagePicker = ImagePicker();
      EasyLoading.show();
      final image = await imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxWidth: 150,
        maxHeight: 150,
      );

      if (image == null) {
        return;
      }

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 40,
        maxWidth: 150,
        maxHeight: 150,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: AppStrings.changeImageStr,
            statusBarColor: AppColors.primaryColor500,
            toolbarColor: AppColors.primaryColor400,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            hidesNavigationBar: true,
            title: AppStrings.changeImageStr,
          ),
        ],
      );

      if (croppedFile != null) {
        final file = ref.read(profileImageProvider.notifier);
        file.state = File(croppedFile.path);
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
