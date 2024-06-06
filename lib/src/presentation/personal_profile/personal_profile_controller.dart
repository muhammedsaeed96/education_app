import 'package:education_app/src/core/enum.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/model/student_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalProfileController extends Notifier<AsyncValue> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> updateAccount<T>({required T data,required T previous }) async {

    final accountType = ref.read(asyncInitProvider).localStorage.getUserInfo()!.accountType;

    if (accountType == AccountType.STUDENT.name) {

      data as StudentModel;
      previous as StudentModel;

      if(data == previous){
        debugPrint('BOTH ARE EQUAL');
      }else{
        debugPrint('BOTH ARE NOT EQUAL');
      }


    } else if (accountType == AccountType.TEACHER.name) {
    } else {}
  }
}

final personalProfileProvider =
    NotifierProvider<PersonalProfileController, AsyncValue>(
  () => PersonalProfileController(),
);

final updateProfileBtnProvider = StateProvider<bool>((ref) => true);
