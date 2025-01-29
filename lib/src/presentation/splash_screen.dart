import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor400,
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => Future.delayed(const Duration(milliseconds: 5), () {
              if (context.mounted) {
                return Navigator.pushReplacementNamed(context, '/');
              }
            }),
          );
          return Center(
            child: Image.asset(
              Assets.icLogo,
              width: size.height * 0.32,
              height: size.height * 0.32,
            ),
          );
        },
      ),
    );
  }
}
