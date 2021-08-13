class AppUrl {
  static const String liveBaseURL = "https://suresms.co.ke:3438/api";
  //static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/AppLogins";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}