import 'package:education_app/src/presentation/academies_screen.dart';
import 'package:education_app/src/presentation/academy_details_screen.dart';
import 'package:education_app/src/presentation/authentication/enter_phone_screen.dart';
import 'package:education_app/src/presentation/authentication/otp_screen.dart';
import 'package:education_app/src/presentation/authentication/sign_in_signup_screen.dart';
import 'package:education_app/src/presentation/home/home_screen.dart';
import 'package:education_app/src/presentation/personal_profile_screen.dart';
import 'package:education_app/src/presentation/select_profile_picture_screen.dart';
import 'package:education_app/src/presentation/teachers_screen.dart';
import '../presentation/about_us_screen.dart';
import '../presentation/account_status_screen.dart';
import '../presentation/filter_screen.dart';
import '../presentation/teacher_details_screen.dart';

final routes = {
  '/': (_) => const HomeScreen(),
  TeacherDetailsScreen.routeName: (_) => const TeacherDetailsScreen(),
  AcademyDetailsScreen.routeName: (_) => const AcademyDetailsScreen(),
  TeachersScreen.routeName: (_) => const TeachersScreen(),
  AcademiesScreen.routeName: (_) => const AcademiesScreen(),
  OtpScreen.routeName: (_) => const OtpScreen(),
  EnterPhoneScreen.routeName: (_) => const EnterPhoneScreen(),
  SignInSignupScreen.routeName: (_) => const SignInSignupScreen(),
  PersonalProfileScreen.routeName: (_) => const PersonalProfileScreen(),
  SelectProfilePictureScreen.routeName:
      (_) => const SelectProfilePictureScreen(),
  AboutUsScreen.routeName: (_) => const AboutUsScreen(),
  FilterScreen.routeName: (_) => const FilterScreen(),
  AccountStatusScreen.routeName: (_) => const AccountStatusScreen(),
};
