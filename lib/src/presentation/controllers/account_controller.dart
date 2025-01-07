import 'dart:io';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/core/utils/async_value_ui.dart';
import 'package:education_app/src/data/account_repository.dart';
import 'package:education_app/src/presentation/controllers/simple_state_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enum.dart';
import '../../model/academy_model.dart';
import '../../model/student_model.dart';
import '../../model/teacher_model.dart';

class AccountController extends AutoDisposeNotifier<AsyncValue<void>> {
  late final AccountRepository _accountRepository;

  @override
  build() {
    _accountRepository = ref.read(accountRepositoryProvider);
    return const AsyncData(null);
  }

  Future<T> getAccount<T>({
    required String accountType,
    String? id,
    bool isPersonalAccount = false,
  }) async {
    if (accountType == AccountType.STUDENT.name) {
      return await _accountRepository.getStudentAccount(id: id!) as T;
    } else if (accountType == AccountType.TEACHER.name) {
      final accountData = await _accountRepository.getTeacherAccount(
        id: id,
        isPersonalAccount: isPersonalAccount,
      ) as T;

      accountData as TeacherModel;

      ref.read(isTeacherTeachingOutstanding.notifier).state =
          accountData.outstandingTeaching;
      ref.read(isTeacherTeachingOnStudentHome.notifier).state =
          accountData.teachingOnStudentHome;

      return accountData;
    } else {
      return await _accountRepository.getAcademyAccount(
        id: id,
        isPersonalAccount: isPersonalAccount,
      ) as T;
    }
  }

  Future<void> updateAccount<T>({
    required String accountType,
    required T data,
    required String id,
  }) async {
    state = const AsyncLoading();

    final AsyncValue<void> result;

    if (accountType == AccountType.STUDENT.name) {
      result = await AsyncValue.guard(
        () => _accountRepository.updateStudentAccount(
          student: data as StudentModel,
          id: id,
        ),
      );
    } else if (accountType == AccountType.TEACHER.name) {
      result = await AsyncValue.guard(
        () => _accountRepository.updateTeacherAccount(
          teacher: data as TeacherModel,
        ),
      );
    } else {
      result = await AsyncValue.guard(
        () => _accountRepository.updateAcademyAccount(
          academy: data as AcademyModel,
        ),
      );
    }

    state = result;
  }

  Future<void> deleteAccount() async {
    final user = ref.read(asyncInitProvider).localStorage.getUserInfo();

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () {
        return _accountRepository.deleteAccount(accountType: user!.accountType);
      },
    );

    if (!state.hasError) {
      await ref.read(asyncInitProvider).localStorage.removeUserInfo();
      ref.read(isAuthenticationProvider.notifier).state = false;
    }
  }

  // TODO we must not pass context and other ui components to controller
  Future<void> uploadProfileImage({
    required BuildContext context,
    required File file,
  }) async {
    final user = ref.read(asyncInitProvider).localStorage.getUserInfo();
    // state = const AsyncLoading();
    EasyLoading.show();
    final result = await AsyncValue.guard(
      () {
        return _accountRepository.uploadProfileImage(
          file: file,
          accountType: user!.accountType,
        );
      },
    );
    EasyLoading.dismiss();

    if (!context.mounted) {
      return;
    }

    if (result.hasError) {
      result.showErrorDialog(context);
    } else {
      ref.invalidate(getAccountDataProvider);
      Navigator.popUntil(context, (route) => route.settings.name == '/');
    }
  }

/*  Future<void> logout() async {
    final user = ref.read(asyncInitProvider).localStorage.getUserInfo();

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () {
        return _accountRepository.logout(accountType: user!.accountType);
      },
    );

    if (!state.hasError) {
      await ref.read(asyncInitProvider).localStorage.removeUserInfo();
      ref.read(logoutProvider.notifier).state = true;
    }
  }*/

  Future<void> logout() async {
    state = const AsyncLoading();
    ref.read(requestOtpAvailableProvider.notifier).state = true;
    await Future.wait([
      ref.read(asyncInitProvider).otpHelper.clearNextAttempt(),
      ref.read(asyncInitProvider).localStorage.removeUserInfo()
    ]);
    ref.read(isAuthenticationProvider.notifier).state = false;
    state = AsyncData(null);
  }
}

final accountControllerProvider =
    NotifierProvider.autoDispose<AccountController, AsyncValue<void>>(
  () => AccountController(),
);

final getAccountDataProvider = FutureProvider.autoDispose.family<dynamic, bool>(
  (ref, isPersonalAccount) {
    final info = ref.read(asyncInitProvider).localStorage.getUserInfo()!;
    return ref.read(accountControllerProvider.notifier).getAccount(
          id: info.userId,
          accountType: info.accountType.name,
          isPersonalAccount: isPersonalAccount,
        );
  },
);
