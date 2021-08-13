import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ApiService{
  getProfiles() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? id = sharedPreferences.getInt("id");
  }
}

Future<LoginResponse> createLoginState(int idNo, String mobileNo, int uniqueId, int saccoId, int verCode,
    String location, String imsi, int pinNo, String model, String simOperator, String netState, String simTel) async {
  final http.Response response = await http.post(Uri.https(
      'https://suresms.co.ke', ':3438/api/AppLogins',),
      headers: <String, String>{
        'Token': 'Token',
        'Accept': 'application/json',
      },
      body: {
        'id_no': idNo,
        'mobile_no': mobileNo,
        'unique_id': uniqueId,
        'sacco_id': saccoId,
        'verification_code': verCode,
        'location': location,
        'imsi': imsi,
        'pin_no': pinNo,
        'model': model,
        'sim_operator': simOperator,
        'network_state': netState,
        'sim_tel': simTel,
      });

  if (response.statusCode == 200) {
    print(response.body);
    return LoginResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to Log in.');
  }
}

class LoginResponse {
  late int idNo;
  late String mobileNo;
  late int uniqueId;
  late int saccoId;
  late int verCode;
  late String location;
  late String imsi;
  late int pinNo;
  late String model;
  late String simOperator;
  late String netState;
  late String simTel;

  LoginResponse(
      {required this.idNo, required this.mobileNo, required this.uniqueId, required this.saccoId, required this.verCode,
      required this.location, required this.imsi, required this.pinNo, required this.model, required this.simOperator, required this.netState, required this.simTel});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    idNo = json['idNo'];
    mobileNo = json['mobileNo'];
    uniqueId = json['uniqueId'];
    saccoId = json['saccoId'];
    verCode = json['verCode'];
    location = json['location'];
    imsi = json['imsi'];
    pinNo = json['pinNo'];
    model = json['model'];
    simOperator = json['simOperator'];
    netState = json['netState'];
    simTel = json['simTel'];
  }
}
