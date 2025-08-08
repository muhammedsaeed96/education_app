// import 'package:education_app/src/common_widgets/async_widget.dart';
// import 'package:education_app/src/core/constants/app_colors.dart';
// import 'package:education_app/src/core/constants/assets.dart';
// import 'package:education_app/src/core/utils/async_init.dart';
// import 'package:education_app/src/model/academy_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../core/enum.dart';
// import '../model/student_model.dart';
// import '../model/teacher_model.dart';
// import 'account_status_screen.dart';
// import 'controllers/account_controller.dart';
//
// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   static const routeName = 'splash_screen';
//
//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   @override
//   void initState() {
//     if (!ref.read(asyncInitProvider).localStorage.isAuth) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushReplacementNamed(context, '/');
//       });
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final value = ref.watch(getAccountDataProvider(true));
//     return Scaffold(
//       backgroundColor:
//           value.hasError ? Colors.white : AppColors.primaryColor400,
//       body: AsyncWidget(
//         value: value,
//         data: (data) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _handleNavigation(context, data);
//           });
//           return Center(
//             child: Image.asset(
//               Assets.icLogo,
//               width: size.height * 0.32,
//               height: size.height * 0.32,
//             ),
//           );
//         },
//         retry: () => ref.invalidate(getAccountDataProvider(true)),
//       ),
//     );
//   }
//
//   void _handleNavigation(BuildContext context, dynamic data) {
//     if (data is StudentModel) {
//       Navigator.pushReplacementNamed(context, '/');
//     } else if (data is TeacherModel) {
//       data.status == AccountStatus.approved
//           ? Navigator.pushReplacementNamed(context, '/')
//           : Navigator.pushReplacementNamed(
//             context,
//             AccountStatusScreen.routeName,
//           );
//     } else {
//       data as AcademyModel;
//       data.status == AccountStatus.approved
//           ? Navigator.pushReplacementNamed(context, '/')
//           : Navigator.pushReplacementNamed(
//             context,
//             AccountStatusScreen.routeName,
//           );
//     }
//   }
// }
