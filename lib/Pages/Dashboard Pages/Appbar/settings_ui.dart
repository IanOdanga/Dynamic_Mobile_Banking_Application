library settings_ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:settings_ui/src/settings_section.dart';
export 'package:settings_ui/src/settings_tile.dart';
export 'package:settings_ui/src/settings_list.dart';
export 'package:settings_ui/src/custom_section.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}