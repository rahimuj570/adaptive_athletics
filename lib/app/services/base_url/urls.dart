class BaseUrl {
  static const String baseUrl = 'http://10.10.13.24:8002/api/v1';

  static const String loginUrl = '$baseUrl/auth/login/email/';
  static const String registerUrl = '$baseUrl/auth/register/';
  static const String sentEmailForgotPassword =
      '$baseUrl/auth/password/forgot/';

  static const String authPasswordVerify = '$baseUrl/auth/password/verify/';
  static const String passwordReset = '$baseUrl/auth/password/reset/';

  static const String getUser = '$baseUrl/auth/profile/';
  static const String getPolicy = '$baseUrl/policy/';
  static const String getTerms = '$baseUrl/terms/';

  static const String postPlan = '$baseUrl/plans/';
  static const String getPlan = '$baseUrl/plans/';

  static const String postEvent = '$baseUrl/events/';
  static const String getEventList = '$baseUrl/events/';
}
