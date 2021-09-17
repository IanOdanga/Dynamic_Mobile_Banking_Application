import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/src/domain/users.dart';
import 'package:untitled/src/util/app_url.dart';
import 'package:untitled/src/util/shared_preferences.dart';


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;


  Future<Map<String, dynamic>> loggingIn(String mobileNo, String pinNo, String idNumber, String uniqueId, String saccoId, String verificationCode, String location, String imsi, String model, String simOperator, String networkState, String simTel) async {
    var result;

    final Map<String, dynamic> loginData = {
      'user': {
        '37359946': idNumber,
        '6556565': uniqueId,
        '00048': saccoId,
        '969628': verificationCode,
        'KIL': location,
        'IME34566': imsi,
        '5299': pinNo,
        'BUNDY': model,
        'SAF': simOperator,
        'SIM DATA': networkState,
        '254740481483': simTel,
        '+254740481483': mobileNo
      }
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse('https://suresms.co.ke:3438/api/AppLogins'),
      body: json.encode(loginData),
      headers: {
        'Token': 'c76189858f8a4f1a72f8bb4193e90823f9fb2581032b6c838aac6dcf7aff966d',
        'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> activation(String mobileNo, String idNumber, String verificationCode, String uniqueId, String saccoId) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'user': {
        '37359946': idNumber,
        '6556565': uniqueId,
        '00048': saccoId,
        '969628': verificationCode,
        '+254740481483': mobileNo
      }
    };
    Response response = await post(
      Uri.parse('https://suresms.co.ke:3438/api/VerifyPhoneNumber'),
      body: json.encode(activation),
      headers: {
        'Token': 'c76189858f8a4f1a72f8bb4193e90823f9fb2581032b6c838aac6dcf7aff966d',
        'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print(response.statusCode);
    if (response.statusCode == 200) {

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
