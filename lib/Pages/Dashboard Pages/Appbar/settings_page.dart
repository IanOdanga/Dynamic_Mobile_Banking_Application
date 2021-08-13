import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:untitled/src/themes/theme.dart';

class SettingsPage extends StatelessWidget {
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
class MySettingsPage extends StatefulWidget {

  MySettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
            )),
        backgroundColor: Colors.cyan.shade200,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Theme and Language',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                subtitleMaxLines: 4,
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: Icon(Icons.phone_android),
                switchValue: isSwitched,
                onToggle: (value) {
                  setState(({ switchValue: true}) {
                    isSwitched = value;
                    EasyDynamicTheme.of(context).changeTheme(dynamic: value);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Section 2',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'Fingerprint',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {
                  setState(() {
                    isSwitched = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}