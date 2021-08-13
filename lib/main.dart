import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled/src/themes/theme.dart';
import 'Pages/Dashboard Pages/Dashboard.dart';
import 'Pages/Login/login_page.dart';
import 'Pages/Welcome/getting_started.dart';
import 'Routes/transition_route_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import 'Services/secure_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final SecureStorageService secureStorageService =
  SecureStorageService(secureStorage);
  final String? refreshToken = await secureStorageService.getRefreshToken();
  final String initialRoute =
  refreshToken == null ? LoginPage.routeName : Dashboard.routeName;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
      SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  MpesaFlutterPlugin.setConsumerKey('Wo7rTAza4USEDomxYuP53AgFFtoQYa9Z');
  MpesaFlutterPlugin.setConsumerSecret('ZHoN8xilr83RFsAN');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMOJA WENDANI SACCO',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('sw', ''),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        accentColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      ),
      //darkTheme: MyThemes.darkTheme,
      //theme: lightThemeData,
      darkTheme: darkThemeData,
      //themeMode: EasyDynamicTheme.of(context).themeMode,
      debugShowCheckedModeBanner: false,
      home: GettingStartedScreen(),
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginPage.routeName,
    );
  }
}