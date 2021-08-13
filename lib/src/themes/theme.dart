import 'package:flutter/material.dart';

var lightThemeData = new ThemeData(
    primaryColor: Colors.cyan.shade200,
    textTheme: new TextTheme(button: TextStyle(color: Colors.white)),
    brightness: Brightness.light,
    accentColor: Colors.cyan.shade200);

var darkThemeData = ThemeData(
    primaryColor: Colors.cyan.shade200,
    textTheme: new TextTheme(button: TextStyle(color: Colors.black)),
    brightness: Brightness.dark,
    accentColor: Colors.cyan.shade200);