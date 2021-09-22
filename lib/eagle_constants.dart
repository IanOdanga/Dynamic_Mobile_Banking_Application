import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const SecondaryColor = Color(0xFFFFFFFF);
const BgColor = Color(0xFF212332);

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
  static const String appName = 'UMOJA WENDANI SACCO';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}
