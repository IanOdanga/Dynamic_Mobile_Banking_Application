import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Pages/Dashboard Pages/Appbar/CheckUpdates.dart';
import 'package:untitled/Pages/Login/login_page.dart';
import 'package:untitled/Pages/Dashboard Pages/Appbar/profile.dart';
import 'package:untitled/Pages/Dashboard Pages/Appbar/settings_page.dart';
import 'package:untitled/Services/api_service.dart';
import 'package:untitled/drawers/nav-drawer.dart';
import 'package:http/http.dart' as http;

Future<http.Response> memberInfo(String mobileNo, String idNumber, String uniqueId) {
  return http.post(
    Uri.parse('https://suresms.co.ke:3438/api/GetmemberInfor'),
    headers: <String, String>{
      'Token': 'c76189858f8a4f1a72f8bb4193e90823f9fb2581032b6c838aac6dcf7aff966d',
      'Accept': 'application/json',
    },
    body: jsonEncode(<String, String>{
      '37359946': idNumber,
      '6556565': uniqueId,
      '+254740481483': mobileNo
    }),
  );
}
class Dashboard extends StatefulWidget {
  static const String routeName = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late BuildContext context;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('DASHBOARD',
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  )
              )
          ),
          centerTitle: true,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme().apply(bodyColor: Colors.white),
              ),
              child: PopupMenuButton<int>(
                color: Colors.cyan.shade200,
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) =>
                [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text('Settings',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                            )
                        )
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text('Profile',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                            )
                        )
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Text('Legal',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(Icons.logout,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text('Log Out',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: .1,
          backgroundColor: Colors.cyan.shade200,
        ),
        backgroundColor: Colors.white,
      );

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MySettingsPage(title: 'Settings',)),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Updates()),
        );
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
    }
  }
}