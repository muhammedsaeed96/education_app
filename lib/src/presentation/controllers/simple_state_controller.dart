import 'dart:io';
import 'package:education_app/src/core/enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// to listen to province value change
final provinceIdProvider = StateProvider.autoDispose<String>((ref) => '');

// to listen to subjects length change
final subjectsIdsChangesProvider = StateProvider.autoDispose<int>((ref) => 0);

// to listen to stages length change
final stagesLengthProvider = StateProvider.autoDispose<int>((ref) => 0);

final otpValueProvider = StateProvider.autoDispose<String>((ref) => '');

final profileImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final isAuthenticationProvider = StateProvider<bool>((ref) => false);

final searchValProvider = StateProvider<String?>((ref) => null);

final requestOtpAvailableProvider = StateProvider<bool>((ref) => false);

final loginToContactWithTeacherAcademy = StateProvider<bool>((ref) => false);

final isTeacherTeachingOutstanding = StateProvider<bool>((ref) => false);

final isTeacherTeachingOnStudentHome = StateProvider<bool>((ref) => false);

final selectedHighlight = StateProvider<HighlightType?>((ref) => null);

final currentNavBarIndexProvider = StateProvider<int>((ref) => 0);
