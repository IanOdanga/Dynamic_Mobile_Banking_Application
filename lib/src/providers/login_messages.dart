import 'package:flutter/material.dart';

class LoginMessages with ChangeNotifier {
  LoginMessages(
      {
      this.passwordHint = defaultPasswordHint,
      this.loginButton = defaultLoginButton,
        this.logoutButton = defaultLogoutButton,
      this.confirmPasswordError = defaultConfirmPasswordError,
      this.flushbarTitleError = defaultflushbarTitleError,
      this.flushbarTitleSuccess = defaultflushbarTitleSuccess,});

  static const defaultPasswordHint = 'Password';
  static const defaultLoginButton = 'LOGIN';
  static const defaultLogoutButton = 'LOGOUT';
  static const defaultGoBackButton = 'BACK';
  static const defaultConfirmPasswordError = 'Incorrect Password!';
  static const defaultflushbarTitleSuccess = 'Success';
  static const defaultflushbarTitleError = 'Error';


  /// Hint text of the userHint [TextField]
  /// By default is Email

  /// Hint text of the password [TextField]
  final String passwordHint;

  /// Login button label
  final String loginButton;

  /// Logout button label
  final String logoutButton;

  /// The error message to show when the confirm password not match with the
  /// original password
  final String confirmPasswordError;

  /// Title on top of Flushbar on errors
  final String flushbarTitleError;

  /// Title on top of Flushbar on successes
  final String flushbarTitleSuccess;

}
