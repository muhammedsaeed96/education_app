import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/model/authentication_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInSignupState {
  final FormType formType;
  final AccountType accountType;
  final AuthenticationModel? authentication;
  final AsyncValue value;

  SignInSignupState({
    required this.formType,
    required this.accountType,
    this.authentication,
    required this.value,
  });

  SignInSignupState copyWith({
    FormType? formType,
    AccountType? accountType,
    AsyncValue? value,
    AuthenticationModel? authentication,
  }) {
    return SignInSignupState(
      formType: formType ?? this.formType,
      accountType: accountType ?? this.accountType,
      authentication: authentication ?? this.authentication,
      value: value ?? this.value,
    );
  }

  bool get isLoading => value.isLoading;
}

extension SignInSignupStateX on SignInSignupState {
/*  String get passwordLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Password (8+ characters)'.hardcoded;
    } else {
      return 'Password'.hardcoded;
    }
  }*/

/*  // Getters
  String get primaryButtonText {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Create an account'.hardcoded;
    } else {
      return 'Sign in'.hardcoded;
    }
  }*/

  bool get isStudentAndSignup {
    return accountType == AccountType.student && formType == FormType.signup;
  }

  bool get isTeacherOrAcademyAndSignup {
    return accountType != AccountType.student && formType == FormType.signup;
  }

  bool get isSignIn => formType == FormType.signIn;

  String get topTitleText {
    if (formType == FormType.signup) {
      return AppStrings.createAccountStr;
    } else {
      return AppStrings.loginStr;
    }
  }

  String get topDescriptionText {
    if (formType == FormType.signup) {
      return AppStrings.signupDescStr;
    } else {
      return AppStrings.loginDescStr;
    }
  }

  String get bottomTitleText {
    if (formType == FormType.signup) {
      return AppStrings.haveAccountStr;
    } else {
      return AppStrings.donNotHaveAccountStr;
    }
  }

  String get bottomButtonText {
    if (formType == FormType.signup) {
      return AppStrings.loginStr;
    } else {
      return AppStrings.createAccountStr;
    }
  }

/*  EmailPasswordSignInFormType get secondaryActionFormType {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else {
      return EmailPasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Registration failed'.hardcoded;
    } else {
      return 'Sign in failed'.hardcoded;
    }
  }

  String get title {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Register'.hardcoded;
    } else {
      return 'Sign in'.hardcoded;
    }
  }

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty
        ? 'Email can\'t be empty'.hardcoded
        : 'Invalid email'.hardcoded;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText = password.isEmpty
        ? 'Password can\'t be empty'.hardcoded
        : 'Password is too short'.hardcoded;
    return showErrorText ? errorText : null;
  }*/
}
