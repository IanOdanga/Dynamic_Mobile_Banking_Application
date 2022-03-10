import 'package:flutter/material.dart';
import 'Resource/display_strings_app2.dart';
import 'Widgets/app_config.dart';
import 'main_common.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "BLUE EAGLE SACCO",
    appInternalId: "eagle",
    stringResource: StringResourceApp2(),
    child: MyApp(),
  );

  mainCommon();

  runApp(configuredApp);
}