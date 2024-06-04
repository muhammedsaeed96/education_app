import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/data/account_repository.dart';
import 'package:education_app/src/model/academy_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/student_model.dart';
import '../model/teacher_model.dart';

class AccountService {
  final AccountRepository accountRepository;

  AccountService(this.accountRepository);

  Future<T> getAccount<T>({
    required String accountType,
    required String id,
    required String token,
  }) async {
    if (accountType == AccountType.student.name) {
      return await accountRepository.getStudentAccount(id: id, token: token)
          as T;
    } else if (accountType == AccountType.teacher.name) {
      return await accountRepository.getTeacherAccount(id: id, token: token)
          as T;
    } else {
      return await accountRepository.getAcademyAccount(id: id, token: token)
          as T;
    }
  }

  Future<void> updateAccount<T>({
    required String accountType,
    required T data,
    required String id,
    required String token,
  }) async {
    if (accountType == AccountType.student.name) {
      await accountRepository.updateStudentAccount(
        student: data as StudentModel,
        id: id,
        token: token,
      );
    } else if (accountType == AccountType.teacher.name) {
      await accountRepository.updateTeacherAccount(
        teacher: data as TeacherModel,
        id: id,
        token: token,
      );
    } else {
      await accountRepository.updateAcademyAccount(
        academy: data as AcademyModel,
        id: id,
        token: token,
      );
    }
  }
}

final accountServiceProvider = Provider(
  (ref) => AccountService(ref.read(accountRepositoryProvider)),
);

final accountProvider = FutureProvider(
  (ref) {
    final info = ref.read(asyncInitProvider).localStorage.getUserInfo()!;
    return ref.read(accountServiceProvider).getAccount(
          id: info.id,
          token: info.token,
          accountType: info.accountType,
        );
  },
);

final teacherProvider = FutureProvider<TeacherModel>(
  (ref) {
    final info = ref.read(asyncInitProvider).localStorage.getUserInfo()!;
    return ref.read(accountRepositoryProvider).getTeacherAccount(
          id: info.id,
          token: info.token,
        );
  },
);

final academyProvider = FutureProvider<AcademyModel>(
  (ref) {
    final info = ref.read(asyncInitProvider).localStorage.getUserInfo()!;
    return ref.read(accountRepositoryProvider).getAcademyAccount(
          id: info.id,
          token: info.token,
        );
  },
);
