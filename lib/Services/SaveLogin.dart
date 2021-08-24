import 'package:shared_preferences/shared_preferences.dart';


import '../../Model/AuthResponse.dart';
import '../../Model/User.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();


  var token; //= (responseJson != null && responseJson.isNotEmpty) ? AuthResponse.fromJson(responseJson).token : "";

  var id; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).id : 0;
  var name; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).name : "";
  var email; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).email : "";
  var mobile;//= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).mobile : "";
  var active; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).active : 0;
  var confirmationCode; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).confirmation_code : "";
  var confirmed; //= (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).confirmed : 0;

  await preferences.setString('token', (token != null && token.length > 0) ? token : "");

  await preferences.setInt('id', (id > 0) ? id : 0);
  await preferences.setString('name', (name.length > 0) ? name : "");
  await preferences.setString('email', (email.length > 0) ? email : "");
  await preferences.setString('mobile', (mobile.length > 0) ? mobile : "");
  await preferences.setInt('active', (active > 0) ? active : 0);
  await preferences.setString('confirmation_code', (confirmationCode.length > 0) ? confirmationCode : "");
  await preferences.setInt('confirmed', (confirmed > 0) ? confirmed : 0);


}