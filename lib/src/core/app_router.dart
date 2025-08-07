import 'package:education_app/src/presentation/academies_screen.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:education_app/src/presentation/authentication/enter_phone_screen.dart';
import 'package:education_app/src/presentation/authentication/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_screen.dart';
import 'package:education_app/src/presentation/home/home_screen.dart';
import 'package:education_app/src/presentation/personal_profile_screen.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:education_app/src/presentation/splash_screen.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';

import '../presentation/about_us_screen.dart';
import '../presentation/account_status_screen.dart';
import '../presentation/filter_screen.dart';
import '../presentation/teacher_details_screen.dart';

final routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  '/': (context) => const HomeScreen(),
  TeacherDetailsScreen.routeName: (context) => const TeacherDetailsScreen(),
  AcademyDetailsScreen.routeName: (context) => const AcademyDetailsScreen(),
  TeachersScreen.routeName: (context) => const TeachersScreen(),
  AcademiesScreen.routeName: (context) => const AcademiesScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  EnterPhoneScreen.routeName: (context) => const EnterPhoneScreen(),
  SignInSignupScreen.routeName: (context) => const SignInSignupScreen(),
  PersonalProfileScreen.routeName: (context) => const PersonalProfileScreen(),
  SelectProfilePictureScreen.routeName: (context) => const SelectProfilePictureScreen(),
  AboutUsScreen.routeName: (context) => const AboutUsScreen(),
  FilterScreen.routeName: (context) => const FilterScreen(),
  AccountStatusScreen.routeName: (context) => const AccountStatusScreen(),
};