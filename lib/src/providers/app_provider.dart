import 'package:shared_preferences/shared_preferences.dart';

class AppProvider{
  AppProvider._();

  static final AppProvider appProvider = AppProvider._();

  addStringToSF () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', "admin@cloudpesateam");
  }

  addIntToSF () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Password', 2345678);
  }

  getStringValuesSF () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('Username');
    return stringValue;
  }

  getIntValuesSF () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt('Password');
    return intValue;
  }
}