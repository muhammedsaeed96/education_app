import 'dart:async';
import 'package:education_app/src/core/constants/app_strings.dart';
import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/authentication_repository.dart';
import 'package:education_app/src/model/authentication_model.dart';
import 'package:education_app/src/model/user_info_model.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_state.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_urls.dart';

class SignInSignupController extends AutoDisposeNotifier<SignInSignupState> {
  @override
  SignInSignupState build() {
    return SignInSignupState(
      formType: FormType.signIn,
      accountType: AccountType.STUDENT,
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

  void saveSignupData({
    String? name,
    required String accountType,
    final String? stageId,
    String? description,
    String? provinceId,
    String? areaId,
    List subjectsIds = const [],
    List stagesIds = const [],
    String? locationDescription,
    String? facebookUrl,
    String? youtubeUrl,
    String? instagramUrl,
    String? telegramUrl,
    String? teachingType,
    bool? outstandingTeaching,
    bool? teachingOnStudentHome,
  }) {
    state = state.copyWith(
      authentication: AuthenticationModel(
        name: name,
        accountType: state.accountType,
        phone: '',
        description: description,
        stageId: stageId,
        provinceId: provinceId,
        areaId: areaId,
        subjectsIds: subjectsIds,
        stagesIds: stagesIds,
        locationDescription: locationDescription,
        facebookUrl: facebookUrl,
        youtubeUrl: youtubeUrl,
        instagramUrl: instagramUrl,
        telegramUrl: telegramUrl,
        teachingType: teachingType,
        outstandingTeaching: outstandingTeaching,
        teachingOnStudentHome: teachingOnStudentHome,
      ),
    );
  }

  Future<bool> requestOtp({
    required String phone,
    required AccountType accountType,
  }) async {
    final authData = state.authentication == null
        ? AuthenticationModel(phone: phone, accountType: accountType)
        : state.authentication?.copyWithPhoneAndAccountType(
            phone: phone,
            accountType: accountType,
          );

    // to check if next otp attempt available

    final otpHelper = ref.read(asyncInitProvider).otpHelper;

    final bool canReqOtp = otpHelper.nextAttemptAvailable();

    if (canReqOtp == false) {
      state = state.copyWith(
        accountType: accountType,
        authentication: authData,
        value: AsyncError(
          otpHelper.getNextAttemptText ?? '',
          StackTrace.current,
        ),
      );
      return false;
    }

    state = state.copyWith(
      authentication: state.authentication == null
          ? AuthenticationModel(
              phone: phone,
              accountType: accountType,
            )
          : state.authentication?.copyWithPhoneAndAccountType(
              phone: phone,
              accountType: accountType,
            ),
    );
    state = state.copyWith(value: const AsyncLoading());
    final value = await AsyncValue.guard(() => _requestOtpByFormType());
    // to increment otp when user send one
    if (!value.hasError) {
     await otpHelper.incrementOtpReqCount();
      ref.read(requestOtpAvailableProvider.notifier).state = otpHelper.nextAttemptAvailable();
    }
    state = state.copyWith(value: value);
    return !value.hasError;
  }

  Future<void> _requestOtpByFormType() async {
    if (state.formType == FormType.signIn) {
      await ref.read(authenticationRepositoryProvider).requestOtpForSignIn(
            phone: state.authentication!.phone,
            accountType: state.authentication!.accountType.name,
          );
    } else {
      await ref.read(authenticationRepositoryProvider).requestOtpForSignup(
            phone: state.authentication!.phone,
            accountType: state.authentication!.accountType.name,
          );
    }
  }

  Future<FormType?> verifyOtp(String otp) async {
    state = state.copyWith(value: const AsyncLoading());

    final AsyncValue<UserInfoModel> result;
    final authRepo = ref.read(authenticationRepositoryProvider);

    if (state.formType == FormType.signIn) {
      // login user
      result = await AsyncValue.guard(
        () => ref.read(authenticationRepositoryProvider).verifyOtp(
              phone: state.authentication!.phone,
              otp: otp,
              accountType: state.authentication!.accountType.name,
            ),
      );
    } else {
      String url = ApiUrls.studentUrl;
      if (state.authentication?.accountType == AccountType.TEACHER) {
        url = ApiUrls.teacherUrl;
      } else if (state.authentication?.accountType == AccountType.ACADEMY) {
        url = ApiUrls.academyUrl;
      }

      state = state.copyWith(
        authentication: state.authentication?.copyWithOtp(otp),
      );

      // create new user account
      result = await AsyncValue.guard(
        () => authRepo.createUserAccount(
          authentication: state.authentication!,
          requestUrl: url,
        ),
      );
    }
    final formType = state.formType;

    if (!result.hasError) {
      await ref
          .read(asyncInitProvider)
          .localStorage
          .storeUserInfo(result.value!);
      // debugPrint(ref.read(asyncInitProvider).localStorage.getUserInfo()!.token);
      state = SignInSignupState(
        formType: FormType.signIn,
        accountType: AccountType.STUDENT,
        value: const AsyncData(null),
      );
      return formType;
    } else {
      state = state.copyWith(value: result);
      return null;
    }
  }

  AccountType _getAccountType(String type) {
    if (type == AppStrings.accountTypes[0]) {
      return AccountType.STUDENT;
    } else if (type == AppStrings.accountTypes[1]) {
      return AccountType.TEACHER;
    } else {
      return AccountType.ACADEMY;
    }
  }
}

final signInSignupControllerProvider =
    NotifierProvider.autoDispose<SignInSignupController, SignInSignupState>(
  () => SignInSignupController(),
);
