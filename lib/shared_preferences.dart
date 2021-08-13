import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

dynamic getInt(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  int? _res = prefs.getInt("$key");
  return _res;
}

dynamic getString(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String? _res = prefs.getString("$key");
  return _res;
}

dynamic getJson(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String? jsonString = prefs.getString("$key");
  var _res = jsonDecode(jsonString!);
  return _res;
}

dynamic putInt(key, val) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var _res = prefs.setInt("$key", val);
  return _res;
}

/// Adding a string value
dynamic putString(key, val) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var _res = prefs.setString("$key", val);
  return _res;
}

dynamic putJson(key, val) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var valString = jsonEncode(val);
  var _res = prefs.setString("$key", valString);
  return _res;
}