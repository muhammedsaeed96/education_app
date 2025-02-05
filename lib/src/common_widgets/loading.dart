import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/constants/assets.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.size = 40}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: CircularProgressIndicator(color: AppColors.primaryColor400),
      child: Lottie.asset(Assets.loading, width: size, height: size),
    );
  }
}
