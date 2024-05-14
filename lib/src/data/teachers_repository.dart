import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/teacher_model.dart';

class TeachersRepository {
  Future<TeacherModel> getTeacher(TeacherID id) async {
    await Future.delayed(const Duration(seconds: 1));
    return dummyTeachers.firstWhere((t) => t.id == id);
  }
}

final teacherRepositoryProvider = Provider.autoDispose<TeachersRepository>(
  (ref) => TeachersRepository(),
);
