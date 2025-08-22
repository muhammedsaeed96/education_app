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
import '../../common_widgets/zoom_tap_animation.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/assets.dart';
import '../../core/utils/app_updater.dart';
import '../account_status_screen.dart';
import 'visitors_screen.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final AppUpdater _appUpdater;

  late final PageController _pageController;

  // int currentNavBarIndex = 0;

  final List<Widget> _pageViewPages = [
    const Home(key: PageStorageKey('page1')),
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
    ref.listen(getHomeDataProvider.select((value) => value), (_, next) async {
      // Handle account status
      if (!next.isLoading &&
          !next.hasError &&
          next.value?.userStatus != null &&
          next.value?.userStatus != 'approved') {
        Navigator.pushReplacementNamed(context, AccountStatusScreen.routeName);
        return;
      }

      // Handle app update if available
      final updateInfo = next.value?.updateInfo;
      if (updateInfo != null) {
        final showUpdaterDialog = await _appUpdater.showUpdateDialog(
          updateInfo,
        );
        if (showUpdaterDialog && context.mounted) {
          appUpdaterDialog(
            context: context,
            updateUrl:
                Platform.isAndroid
                    ? updateInfo.playStoreUrl
                    : updateInfo.appStoreUrl,
          );
        }
      }
    });

    ref.listen(
      isAuthenticationProvider,
      (_, next) => _updateBottomNavBarItems(next),
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: PageView.builder(
                onPageChanged: (_) => setState(() {}),
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (_, i) => _pageViewPages[i],
                itemCount: _pageViewPages.length,
              ),
            ),
          ),
          BottomNavBar(pageController: _pageController),
        ],
      ),
    );
  }

  void _updateBottomNavBarItems(bool next) {
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
    _changeNavBarIndex(index: 0);
  }

  void _changeNavBarIndex({required int index}) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      ref.read(currentNavBarIndexProvider.notifier).state = index;
    });
  }

  bool get _isAuth => ref.read(asyncInitProvider).localStorage.isAuth;

  bool get _isNotStudent {
    return ref.read(asyncInitProvider).localStorage.isNotStudent();
  }
}

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = ref.read(asyncInitProvider).localStorage.isAuth;
    final isNotStudent =
        ref.read(asyncInitProvider).localStorage.isNotStudent();

    return Consumer(
      builder: (_, ref, _) {
        ref.watch(isAuthenticationProvider);
        ref.watch(currentNavBarIndexProvider);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(24),
                offset: Offset(0, -1),
                blurRadius: 12,
              ),
            ],
            color: Colors.white,
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavBarItem(
                  index: 0,
                  currentIndex: ref.read(currentNavBarIndexProvider),
                  text: AppStrings.homeStr,
                  isAuth: isAuth,
                  isNotStudent: isNotStudent,
                  onTapped: () {
                    _changeNavBarIndex(index: 0, ref: ref);
                  },
                ),
                if (isAuth)
                  NavBarItem(
                    index: 1,
                    currentIndex: ref.read(currentNavBarIndexProvider),
                    text:
                        isNotStudent
                            ? AppStrings.visitStr
                            : AppStrings.communicationStr,
                    isAuth: isAuth,
                    isNotStudent: isNotStudent,
                    onTapped: () {
                      _changeNavBarIndex(index: 1, ref: ref);
                    },
                  ),
                NavBarItem(
                  index: isAuth ? 2 : 1,
                  currentIndex: ref.read(currentNavBarIndexProvider),
                  text: AppStrings.callUsStr,
                  isAuth: isAuth,
                  isNotStudent: isNotStudent,
                  onTapped: () {
                    _changeNavBarIndex(index: isAuth ? 2 : 1, ref: ref);
                  },
                ),
                NavBarItem(
                  index: isAuth ? 3 : 2,
                  currentIndex: ref.read(currentNavBarIndexProvider),
                  text: AppStrings.accountStr,
                  isAuth: isAuth,
                  isNotStudent: isNotStudent,
                  onTapped: () {
                    _changeNavBarIndex(index: isAuth ? 3 : 2, ref: ref);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeNavBarIndex({required int index, required WidgetRef ref}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    ref.read(currentNavBarIndexProvider.notifier).state = index;
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.text,
    required this.isAuth,
    required this.isNotStudent,
    required this.onTapped,
  });

  final int index;
  final int currentIndex;
  final String text;
  final bool isAuth;
  final bool isNotStudent;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getImageUrlByIndex(
      index: index,
      currentIndex: currentIndex,
      isAuth: isAuth,
      isNotStudent: isNotStudent,
    );

    return ZoomTapAnimation(
      onTap:onTapped,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1),
        // color: Colors.white,
        width:
            (isAuth
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 3) -
            2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: SvgPicture.asset(
                key: ValueKey(imageUrl),
                imageUrl,
                width: AppSizes.length20,
                height: AppSizes.length20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: AppTextStyles.textSemiBoldStyle12.copyWith(
                color:
                    index == currentIndex
                        ? AppColors.primaryColor400
                        : AppColors.gray500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageUrlByIndex({
    required int index,
    required int currentIndex,
    required bool isAuth,
    required bool isNotStudent,
  }) {
    String icon;
    switch (index) {
      case 0:
        icon = Assets.icHome;
        break;
      case 1:
        icon =
            !isAuth
                ? Assets.icPhone
                : isNotStudent
                ? Assets.icEye
                : Assets.icUsers;
        break;
      case 2:
        icon = !isAuth ? Assets.icUser : Assets.icPhone;
        break;
      default:
        icon = Assets.icUser;
    }
    return index == currentIndex ? icon.split('.')[0] + '_fill.svg' : icon;
  }
}
