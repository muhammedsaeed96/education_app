import 'dart:io';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/account_repository.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
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
    required String id,
    bool isPersonalAccount = false,
  }) async {
    if (accountType == AccountType.STUDENT.name) {
      return await _accountRepository.getStudentAccount(id: id) as T;
    } else if (accountType == AccountType.TEACHER.name) {
      return await _accountRepository.getTeacherAccount(
        id: id,
        isPersonalAccount: isPersonalAccount,
      ) as T;
    } else {
      return await _accountRepository.getAcademyAccount(id: id) as T;
    }
  }

  Future<void> updateAccount<T>({
    required String accountType,
    required T data,
    required String id,
  }) async {
    if (accountType == AccountType.STUDENT.name) {
      await _accountRepository.updateStudentAccount(
        student: data as StudentModel,
        id: id,
      );
    } else if (accountType == AccountType.TEACHER.name) {
      await _accountRepository.updateTeacherAccount(
        teacher: data as TeacherModel,
        id: id,
      );
    } else {
      await _accountRepository.updateAcademyAccount(
        academy: data as AcademyModel,
        id: id,
      );
    }
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
      ref.read(logoutProvider.notifier).state = true;
    }
  }

  Future<void> uploadProfileImage({required File file}) async {
    final user = ref.read(asyncInitProvider).localStorage.getUserInfo();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () {
        return _accountRepository.uploadProfileImage(
            file: file, accountType: user!.accountType);
      },
    );
  }

  Future<void> logout() async {
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
