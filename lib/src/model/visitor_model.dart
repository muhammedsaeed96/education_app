import 'package:education_app/src/model/student_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VisitorModel {
  final int accountVisitorsNumber;
  final int reservationNumbers;
  final List<StudentModel> students;

  VisitorModel({
    required this.accountVisitorsNumber,
    required this.reservationNumbers,
    this.students = const [],
  });

  factory VisitorModel.fromJson(Map<String, dynamic> data) =>
      _$VisitorModelFromJson(data);

  Map<String, dynamic> toJson() => _$VisitorModelToJson(this);
}
