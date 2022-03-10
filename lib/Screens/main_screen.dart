import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Screens/legal_screen.dart';
import 'package:untitled/Screens/login_screen.dart';
import 'package:untitled/Screens/profile_screen.dart';
import 'package:untitled/Screens/settings_page.dart';
import 'package:untitled/Services/api_service.dart';
import 'package:untitled/Widgets/app_config.dart';
import 'package:http/http.dart' as http;

import '../placeholder_widget.dart';

/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}*/

class Dashboard extends StatefulWidget {
  static const String idScreen = "dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const String idScreen = "dashboard";

  late BuildContext context;
  late SharedPreferences sharedPreferences;

  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  @override
  void initState() {
    super.initState();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  final _advancedDrawerController = AdvancedDrawerController();

  TextEditingController pickupTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return Scaffold(
      /*appBar: AppBar(
        title: Text("Umoja Wendani Sacco"),
      ),*/
      body: _buildBody(/*config!.appInternalId*/),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.supervised_user_circle_outlined),
              label: 'User Information'
          ),
          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.balanceScale),
            label: 'Member Statistics',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Mini Statements',
          ),
          new BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.moneyCheck),
            label: 'Loans',
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_balance),
              label: 'Cash Deposits'
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance_wallet_outlined),
            label: 'Withdraw Funds',
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.compare_arrows),
            label: 'Funds Transfer',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Purchase Airtime',
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return AdvancedDrawer(
      backdropColor: Colors.teal,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
         boxShadow: <BoxShadow>[
           BoxShadow(
             color: Colors.black12,
             blurRadius: 0.0,
           ),
         ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Umoja Wendani Sacco",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.black87,
                       
                  )
              )
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.white,
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/umoja/icon.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ProfilePage.idScreen, (route) => false);
                  },
                  leading: const Icon(Icons.account_circle_rounded),
                  title: Text('Profile',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black87,
                               
                          )
                      )
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SettingsPage.idScreen, (route) => false);
                  },
                  leading: const Icon(Icons.settings),
                  title: Text('Settings',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black87,
                               
                          )
                      )
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Updates.idScreen, (route) => false);
                  },
                  leading: const Icon(Icons.info_rounded),
                  title: Text('Legal',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black87,
                               
                          )
                      )
                  ),
                ),
                const Spacer(),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.idScreen, (route) => false);
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: Text('Logout',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black87,
                               
                          )
                      )
                  ),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.black87,
                                 
                            )
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}