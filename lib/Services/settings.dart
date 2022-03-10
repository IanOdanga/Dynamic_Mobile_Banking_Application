import 'package:shared_preferences/shared_preferences.dart';

Future <void> apiDetails() async {
  String username = "admin@cloudpesateam";
  String password = "CloudPesa@2021.";

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('Username', username);
  prefs.setString('Password', password);
}