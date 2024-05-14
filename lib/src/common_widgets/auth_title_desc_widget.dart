import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';


class AuthTitleDescWidget extends StatelessWidget {
  const AuthTitleDescWidget({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black87),
        ),
        gap4,
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.gray500),
        ),
      ],
    );
  }
}
