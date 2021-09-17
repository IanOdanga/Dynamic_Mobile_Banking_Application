import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/main_common.dart';

late SharedPreferences prefs;

class SharedPref extends StatelessWidget{
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}
save() async {
  var $token;
  await SharedPref.init();
  prefs.setString('Token', $token);
  prefs.setInt('Phone Number', 254740481483);
}

fetch() async {
  String stringVal = prefs.getString('string') ?? '';
  int intVal = prefs.getInt('Integer') ?? 0;
  log("\n string - $stringVal \n Int - $intVal");
}
