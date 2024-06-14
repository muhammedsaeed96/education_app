import 'dart:io';
import 'package:education_app/src/common_widgets/app_updater_dialog.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/home_repository.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:education_app/src/presentation/home/pages/account/account.dart';
import 'package:education_app/src/presentation/home/pages/contact_us.dart';
import 'package:education_app/src/presentation/home/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/assets.dart';
import '../../core/utils/app_updater.dart';
import '../authentication/sign_in_signup_screen.dart';
import '../visitors_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final AppUpdater _appUpdater;

  late final PageController _pageController;
  int currentNavBarIndex = 0;

  final List<Widget> _pageViewPages = [
    const Home(),
     const VisitorsScreen(),
    const ContactUs(),
    const Account(),
  ];

  @override
  void initState() {
    _appUpdater = AppUpdater();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getHomeDataProvider.select((value) => value),
        (previous, next) async {
      final updateInfo = next.value?.updateInfo;
      if (updateInfo == null) {
        return;
      }
      final showUpdaterDialog = await _appUpdater.showUpdateDialog(updateInfo);
      if (showUpdaterDialog && context.mounted) {
        appUpdaterDialog(
          context: context,
          updateUrl: Platform.isAndroid
              ? updateInfo.playStoreUrl
              : updateInfo.appStoreUrl,
        );
      }
    });

    ref.listen(logoutProvider, (_, next) {
      _changeNavBarIndex(index: next ? 0 : 3, ref: ref);
    });

    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (_, i) => _pageViewPages[i],
          itemCount: _pageViewPages.length,
        ),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Widget _bottomNavBar() {

    return Consumer(builder: (context, ref, child) {
      ref.watch(logoutProvider);
      final isNotStudent =
          ref.read(asyncInitProvider).localStorage.isNotStudent();
      return Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.gray200)),
        ),
        height: getProportionateScreenHeight(58),
        child: Row(
          children: [
            _navBarItem(index: 0, text: AppStrings.homeStr),
            isNotStudent
                ? _navBarItem(index: 1, text: AppStrings.visitStr)
                : const SizedBox.shrink(),
            _navBarItem(index: 2, text: AppStrings.callUsStr),
            _navBarItem(index: 3, text: AppStrings.accountStr),
          ],
        ),
      );
    });
  }

  Widget _navBarItem({
    required int index,
    required String text,
  }) {
    final isNotStudent =
        ref.read(asyncInitProvider).localStorage.isNotStudent();
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => _changeNavBarIndex(index: index, ref: ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          width:
          (isNotStudent ? AppSizes.screenWidth / 4 : AppSizes.screenWidth / 3) - 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: SvgPicture.asset(
                  key: ValueKey(_getImageUrlByIndex(index)),
                  _getImageUrlByIndex(index),
                  width: AppSizes.length24,
                  height: AppSizes.length24,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: AppTextStyles.textSemiBoldStyle12.copyWith(
                  color: index == currentNavBarIndex
                      ? AppColors.primaryColor400
                      : AppColors.gray500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getImageUrlByIndex(int index) {
    if (index == 0) {
      return index == currentNavBarIndex ? Assets.icHomeFill : Assets.icHome;
    } else if (index == 1) {
      return index == currentNavBarIndex ? Assets.icEyeFill : Assets.icEye;
    } else if (index == 2) {
      return index == currentNavBarIndex ? Assets.icPhoneFill : Assets.icPhone;
    } else {
      return index == currentNavBarIndex ? Assets.icUserFill : Assets.icUser;
    }
  }

  void _changeNavBarIndex({required int index, required WidgetRef ref}) {
    final userInfo = ref.read(asyncInitProvider).localStorage.getUserInfo();
    if (index == 3 && userInfo == null) {
      Navigator.pushNamed(context, SignInSignupScreen.routeName);
      return;
    }

    setState(() {
      currentNavBarIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }
}
