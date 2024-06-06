class ApiUrls {

  ApiUrls._();

  static const baseUrl = 'http://localhost';
  static const getHomeUrl = '$baseUrl/home';
  static const getTeacherUrl = '$baseUrl/teacher';
  static const getAcademyUrl = '$baseUrl/academy';
  static const getContactInfoUrl = '$baseUrl/general';
  static const getAboutUsUrl = '$baseUrl/general/about';

  // authorization url

   static const requestOtpForSignInUrl = '$baseUrl/authentication/requestOtpForSignIn';
   static const requestOtpForSignupUrl = '$baseUrl/authentication/requestOtpForSignup';
   static const verifyOtpUrl = '$baseUrl/authentication/verifyOtp';

   static const studentUrl = '$baseUrl/student';

}