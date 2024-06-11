class ApiUrls {

  ApiUrls._();

  static const baseUrl = 'http://localhost';
  static const getHomeUrl = '$baseUrl/home';
  static const getTeacherUrl = '$baseUrl/teacher';
  static const getTeacherPersonalAccountUrl = '$baseUrl/teacher/personalAccount';
  static const getAcademyUrl = '$baseUrl/academy';
  static const getAcademyPersonalAccountUrlUrl = '$baseUrl/academy/personalAccount';
  static const getContactInfoUrl = '$baseUrl/general';
  static const getAboutUsUrl = '$baseUrl/general/about';
  static const uploadProfileImageUrl = '$baseUrl/general/uploadProfileImage';

  // authorization url
   static const requestOtpForSignInUrl = '$baseUrl/authentication/requestOtpForSignIn';
   static const requestOtpForSignupUrl = '$baseUrl/authentication/requestOtpForSignup';
   static const verifyOtpUrl = '$baseUrl/authentication/verifyOtp';
   static const deleteAccountUrl = '$baseUrl/authentication/deleteAccount';
   static const logoutUrl = '$baseUrl/authentication/logout';
   static const studentUrl = '$baseUrl/student';

   static const privacyUrl = 'https://learning.opencode.iq/';

}