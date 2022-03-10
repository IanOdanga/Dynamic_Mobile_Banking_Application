import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:untitled/src/themes/theme.dart';
import 'Screens/deposits_screen.dart';
import 'Screens/legal_screen.dart';
import 'Screens/profile_screen.dart';
import 'Screens/settings_page.dart';
import 'Screens/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'Screens/cash_withdrawals_screen.dart';
import 'Screens/funds_transfer_screen.dart';
import 'Screens/loans_screen.dart';
import 'Screens/statements.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';
import 'Routes/transition_route_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'Services/secure_storage_service.dart';
import 'Widgets/app_config.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final SecureStorageService secureStorageService =
  SecureStorageService(secureStorage);
  final String? refreshToken = await secureStorageService.getRefreshToken();
  //final String initialRoute =
  //refreshToken == null ? LoginPage.idScreen : Dashboard.idScreen;
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
    var config = AppConfig.of(context);
    return _buildApp(/*config!.appDisplayName*/);
  }
  Widget _buildApp(/*String appName*/){{
    return MaterialApp(
      /*title: appName,*/
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
      initialRoute: LoginPage.idScreen,
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.home,
            nextScreen: LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.blue),
      routes:{
        SignupScreen.idScreen: (context) => SignupScreen(),
        LoginPage.idScreen: (context) => LoginPage(),
        Dashboard.idScreen: (context) => Dashboard(),
        ProfilePage.idScreen: (context) => ProfilePage(),
        SettingsPage.idScreen: (context) => SettingsPage(),
        Updates.idScreen: (context) => Updates(),
        CashWithdrawals.idScreen: (context) => CashWithdrawals(),
        DepositsPage.idScreen: (context) => DepositsPage(),
        FundsTransfer.idScreen: (context) => FundsTransfer(),
        LoansPage.idScreen: (context) => LoansPage(),
        StatementsPage.idScreen: (context) => StatementsPage(),
      },
      navigatorObservers: [TransitionRouteObserver()],
        );
    }
  }
}