import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_sizes.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:education_app/src/presentation/academies_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor400,
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => Future.delayed(const Duration(milliseconds: 5), () {
              if (context.mounted) {
                return Navigator.pushReplacementNamed(context, AcademiesScreen.routeName);
              }
            }),
          );
          return Center(
            child: Image.asset(
              Assets.icLogo,
              width: AppSizes.screenHeight * 0.32,
              height: AppSizes.screenHeight * 0.32,
            ),
          );
        },
      ),
    );
  }
}
