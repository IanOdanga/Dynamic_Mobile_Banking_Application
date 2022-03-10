import 'package:flutter/material.dart';
import 'Resource/display_strings_app3.dart';
import 'Widgets/app_config.dart';
import 'main_common.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "Vision SACCO",
    appInternalId: "vision",
    stringResource: StringResourceApp3(),
    child: MyApp(),
  );

  mainCommon();

  runApp(configuredApp);
}