import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/current_filters_model.dart';

// to listen to province value change
final provinceProvider = StateProvider.autoDispose<String>((ref) => '');

// to listen to subjects length change
final subjectsChangesProvider = StateProvider.autoDispose<int>((ref) => 0);

// to listen to stages length change
final stagesLengthProvider = StateProvider.autoDispose<int>((ref) => 0);

final otpValueProvider = StateProvider<String>((ref) => '');

final profileImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final logoutProvider = StateProvider.autoDispose<bool>((ref) => false);

final searchValProvider = StateProvider<String?>((ref) => null);
