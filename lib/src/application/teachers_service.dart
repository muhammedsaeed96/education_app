import 'package:education_app/src/data/teachers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/teacher_model.dart';

class TeachersService {
  final TeachersRepository teachersRepository;

  TeachersService(this.teachersRepository);

  Future<TeacherModel> getTeacher(TeacherID id) async {
    return await teachersRepository.getTeacher(id);
  }
}

final teacherServiceProvider = Provider.autoDispose<TeachersService>(
  (ref) => TeachersService(ref.read(teacherRepositoryProvider)),
);

final getTeacherByIdProvider =
    FutureProvider.autoDispose.family<TeacherModel, TeacherID>(
  (ref, id) => ref.read(teacherServiceProvider).getTeacher(id),
);
