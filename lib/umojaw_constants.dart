import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFF95E0FF);
const secondaryColor = Color(0xFF008080);
const bgColor = Color(0xFF212332);

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
