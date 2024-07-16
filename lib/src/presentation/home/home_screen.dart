import 'dart:io';
import 'package:education_app/src/common_widgets/app_updater_dialog.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/home_repository.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:education_app/src/presentation/home/pages/account/account.dart';
import 'package:education_app/src/presentation/home/pages/contact_us.dart';
import 'package:education_app/src/presentation/home/pages/home/home.dart';
import 'package:education_app/src/presentation/home/pages/student_communications/communications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/assets.dart';
import '../../core/utils/app_updater.dart';
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
    const Home(
      key: PageStorageKey('page1'),
    ),
    const ContactUs(key: PageStorageKey('page2')),
    const Account(key: PageStorageKey('page3')),
  ];

  @override
  void initState() {
    _appUpdater = AppUpdater();
    _pageController = PageController(initialPage: 0);
    if (_isAuth) {
      _pageViewPages.insert(
        1,
        _isNotStudent
            ? const VisitorsScreen(key: PageStorageKey('page4'))
            : const CommunicationsPage(key: PageStorageKey('page4')),
      );
    }
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

    ref.listen(isAuthenticationProvider, (_, next) {
      if (_isAuth && _pageViewPages.length < 4) {
        _pageViewPages.insert(
          1,
          _isNotStudent
              ? const VisitorsScreen(key: PageStorageKey('page4'))
              : const CommunicationsPage(key: PageStorageKey('page4')),
        );
      }
      if (!next && _pageViewPages.length == 4) {
        _pageViewPages.removeAt(1);
      }

      _changeNavBarIndex(
        index: !next
            ? 0
            : _isAuth
                ? 3
                : 2,
        // ref: ref,
      );
    });

    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          onPageChanged: (_) => setState(() {}),
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
    final isAuth = ref.read(asyncInitProvider).localStorage.isAuth;

    return Consumer(builder: (context, ref, child) {
      ref.watch(isAuthenticationProvider);
      return Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.gray200)),
        ),
        height: getProportionateScreenHeight(Platform.isAndroid ? 76 : 56),
        child: Row(
          children: [
            _navBarItem(index: 0, text: AppStrings.homeStr),
            isAuth
                ? _navBarItem(
                    index: 1,
                    text: _isNotStudent
                        ? AppStrings.visitStr
                        : AppStrings.communicationStr,
                  )
                : const SizedBox.shrink(),
            _navBarItem(
              index: isAuth ? 2 : 1,
              text: AppStrings.callUsStr,
            ),
            _navBarItem(
              index: isAuth ? 3 : 2,
              text: AppStrings.accountStr,
            ),
          ],
        ),
      );
    });
  }

  Widget _navBarItem({
    required int index,
    required String text,
  }) {
    return InkWell(
      highlightColor: AppColors.gray50,
      focusColor: Colors.transparent,
      splashColor: AppColors.primaryColor50.withOpacity(0.2),
      onTap: () => _changeNavBarIndex(index: index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          width: (_isAuth
                  ? MediaQuery.of(context).size.width / 4
                  : MediaQuery.of(context).size.width / 3) -
              8,
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
    String icon;
    switch (index) {
      case 0:
        icon = Assets.icHome;
        break;
      case 1:
        icon = !_isAuth
            ? Assets.icPhone
            : _isNotStudent
                ? Assets.icEye
                : Assets.icUsers;
        break;
      case 2:
        icon = !_isAuth ? Assets.icUser : Assets.icPhone;
        break;
      default:
        icon = Assets.icUser;
    }
    return index == currentNavBarIndex
        ? icon.split('.')[0] + '_fill.svg'
        : icon;
  }

  void _changeNavBarIndex({required int index}) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      currentNavBarIndex = index;
    });
  }

  bool get _isAuth {
    return ref.read(asyncInitProvider).localStorage.isAuth;
  }

  bool get _isNotStudent {
    return ref.read(asyncInitProvider).localStorage.isNotStudent();
  }
}
