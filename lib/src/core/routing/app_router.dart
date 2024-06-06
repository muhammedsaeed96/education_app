import 'package:education_app/src/presentation/academies_screen.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:education_app/src/presentation/authentication/otp/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_screen.dart';
import 'package:education_app/src/presentation/home/home_screen.dart';
import 'package:education_app/src/presentation/personal_profile/personal_profile_screen.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';

import '../../presentation/teacher_details_screen.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  TeacherDetailsScreen.routeName: (context) => const TeacherDetailsScreen(),
  AcademyDetailsScreen.routeName: (context) => const AcademyDetailsScreen(),
  TeachersScreen.routeName: (context) => const TeachersScreen(),
  AcademiesScreen.routeName: (context) => const AcademiesScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  SignInSignupScreen.routeName: (context) => const SignInSignupScreen(),
  PersonalProfileScreen.routeName: (context) => const PersonalProfileScreen(),
};