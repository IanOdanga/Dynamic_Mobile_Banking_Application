import 'package:flutter/material.dart';
import 'package:untitled/umojaw_constants.dart';
import 'package:untitled/eagle_constants.dart';

const primaryColor = PrimaryColor;
const secondaryColor = SecondaryColor;
const bgColor = BgColor;

enum AlertAction {
  cancel,
  discard,
  disagree,
  agree,
}

const String apiURL = "https://suresms.co.ke:3438/api/GetToken";
const bool devMode = false;
const double textScaleFactor = 1.0;

const defaultPadding = 16.0;
class Constants {
  static const double kPadding = 10.0;
  static const Color orange = Color(0XFFec8d2f);
  static const Color red = Color(0XFFf44336);
  static const String appName = 'UMOJA WENDANI SACCO';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}
