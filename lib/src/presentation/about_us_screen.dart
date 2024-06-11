import 'package:education_app/src/common_widgets/async_widget.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/data/general_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({super.key});

  static const routeName = '/about_us_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getAboutAsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.aboutAppStr)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AsyncWidget(
            value: value,
            data: (aboutText) => Text(
              aboutText,
              textAlign: TextAlign.center,
              style: AppTextStyles.textRegularStyle16,
            ),
            retry: () => ref.invalidate(getAboutAsProvider),
          )
        ],
      ),
    );
  }
}
