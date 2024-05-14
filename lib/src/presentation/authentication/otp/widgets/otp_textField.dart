import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/presentation/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/constants/app_sizes.dart';

class OtpTextField extends ConsumerWidget {
  const OtpTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppSizes.length72,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          showCursor: false,
          autoDisposeControllers: false,
          appContext: context,
          controller: null,
          onChanged: (val) {
            ref
                .read(otpValueProvider.notifier)
                .update((state) => val);
          },
          length: 4,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: AppColors.black87),
          enableActiveFill: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: AppSizes.length72,
            fieldWidth: AppSizes.length72,
            inactiveFillColor: AppColors.gray100,
            activeFillColor: AppColors.green50,
            selectedFillColor: AppColors.green50,
            disabledColor: AppColors.gray100,
            inactiveColor: AppColors.gray200,
            activeColor: AppColors.gray300,
            selectedColor: AppColors.green50,
            activeBorderWidth: 1,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
