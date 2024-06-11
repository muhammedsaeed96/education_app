import 'package:education_app/src/common_widgets/primary_elevated_btn.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/url_launcher_helper.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';

Future appUpdaterDialog({
  required BuildContext context,
  required String updateUrl,
}) async {
  await showDialog(
    barrierDismissible: false,
    useSafeArea: false,
    context: context,
    builder: (_) => PopScope(
      canPop: false,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shadowColor: null,
        shape: null,
        surfaceTintColor: null,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w20,
                vertical: AppSizes.length15,
              ),
              height: AppSizes.length132,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: AppSizes.length2,
                dense: false,
/*                leading: Padding(
                  padding: EdgeInsets.only(left: AppSizes.w6),
                  child: SvgPicture.asset(
                    Assets.icSuccess,
                    width: 16,
                    height: 16,
                  ),
                ),*/
                title: Text(
                  AppStrings.newUpdateStr,
                  style: AppTextStyles.textSemiBoldStyle16.copyWith(
                    color: AppColors.primaryColor500,
                  ),
                ),
                subtitle: Text(
                  AppStrings.findOutUpdateStr,
                  style: AppTextStyles.textRegularStyle14,
                  maxLines: 2,
                ),
                trailing: PrimaryElevatedBtn(
                  height: AppSizes.length44,
                  width: AppSizes.w98,
                  radius: 32,
                  text: AppStrings.editStr,
                  press: () => UrlLauncherHelper.launchUrlByType(
                    updateUrl,
                    LinkType.link,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
