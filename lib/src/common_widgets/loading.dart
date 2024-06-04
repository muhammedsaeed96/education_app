import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.size = 40}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor400),
      ),
    );
  }
}
