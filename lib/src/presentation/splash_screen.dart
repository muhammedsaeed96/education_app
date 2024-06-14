import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          Future.delayed(
            const Duration(milliseconds: 150),
            () => Navigator.pushReplacementNamed(context, '/'),
          );
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
