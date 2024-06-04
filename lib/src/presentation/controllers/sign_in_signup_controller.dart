import 'dart:async';
import 'package:education_app/src/application/authentication_service.dart';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/authentication_model.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInSignupController extends Notifier<SignInSignupState> {
  @override
  SignInSignupState build() {
    return SignInSignupState(
      formType: FormType.signIn,
      accountType: AccountType.student,
      value: const AsyncData(null),
    );
  }

  // to convert form type to either sign in or signup
  void updateFormType() {
    if (state.formType == FormType.signIn) {
      state = state.copyWith(formType: FormType.signup);
    } else {
      state = state.copyWith(formType: FormType.signIn);
    }
  }

  void updateRegistrationType(String type) {
    state = state.copyWith(accountType: _getAccountType(type));
  }

  Future<bool> requestOtp({
     String? name,
    required String phone,
    required String accountType,
    final String? stage,
    String? description,
    String? province,
    String? area,
    List subjects = const [],
    List stages = const [],
    String? locationDescription,
  }) async {
    state = state.copyWith(
        authentication: AuthenticationModel(
      accountType: state.accountType,
      phone: phone,
      description: description,
      stage: stage,
      province: province,
      area: area,
      subjects: subjects,
      stages: stages,
      locationDescription: locationDescription,
    ));
    state = state.copyWith(value: const AsyncLoading());
    final value = await AsyncValue.guard(() => _requestOtpByFormType());
    state = state.copyWith(value: value);

    if (!value.hasError) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _requestOtpByFormType() async {
    if (state.formType == FormType.signIn) {
      debugPrint('requestOtpForSignIn');
      await ref.read(authenticationServiceProvider).requestOtpForSignIn(
            phone: state.authentication!.phone,
            accountType: state.authentication!.accountType.name,
          );
    } else {
      debugPrint('requestOtpForSignup');
      await ref.read(authenticationServiceProvider).requestOtpForSignup(
            phone: state.authentication!.phone,
            accountType: state.authentication!.accountType.name,
          );
    }
  }

  Future<void> verifyOtp(String otp) async {
    final AsyncValue<void> value;

    state = state.copyWith(value: const AsyncLoading());
    if (state.formType == FormType.signIn) {
      // login user
      value = await AsyncValue.guard(
        () => ref.read(authenticationServiceProvider).verifyOtp(
              phone: state.authentication!.phone,
              otp: otp,
              accountType: state.authentication!.accountType.name,
            ),
      );
    } else {
      // create new user account
      state = state.copyWith(
          authentication: state.authentication?.copyWithOtp(otp));
      value = await AsyncValue.guard(
        () => ref
            .read(authenticationServiceProvider)
            .createUserAccount(state.authentication!),
      );
    }
    // to return state to default state
    state = state.copyWith(
      value: value,
      formType: FormType.signIn,
      accountType: AccountType.student,
    );
  }

  AccountType _getAccountType(String type) {
    if (type == AppStrings.accountTypes[0]) {
      return AccountType.student;
    } else if (type == AppStrings.accountTypes[1]) {
      return AccountType.teacher;
    } else {
      return AccountType.academy;
    }
  }
}

final signInSignupControllerProvider =
    NotifierProvider<SignInSignupController, SignInSignupState>(
  () => SignInSignupController(),
);
