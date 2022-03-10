import 'package:flutter/material.dart';
import 'Resource/display_strings_app1.dart';
import 'Widgets/app_config.dart';
import 'main_common.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "UMOJA WENDANI SACCO",
    appInternalId: "umoja",
    stringResource: StringResourceApp1(),
    child: MyApp(),
  );

  mainCommon();

  runApp(configuredApp);
}