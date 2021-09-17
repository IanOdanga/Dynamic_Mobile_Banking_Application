import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Pages/Dashboard Pages/Dashboard.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
export 'package:untitled/Pages/Login/Auth.dart';
export 'package:untitled/src/models/login_user_type.dart';
export 'package:untitled/src/providers/login_messages.dart';
export 'package:untitled/src/providers/login_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Pages/Login/Auth.dart';
import 'package:untitled/Providers/user_provider.dart';
import 'package:untitled/Widgets/app_config.dart';
import 'package:untitled/Widgets/placeholder_widget.dart';
import 'package:untitled/src/util/widgets.dart';
import '../../Services/authorization_service.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:untitled/src/domain/users.dart';
import 'package:untitled/Services/authorization_service.dart';
import 'package:untitled/Services/secure_storage_service.dart';
import 'package:untitled/Model/login_model.dart';

class LandingViewModel extends ChangeNotifier {
  bool _logIn = false;
  bool get logIn => _logIn;
  final AuthorizationService authorizationService;
  LandingViewModel(this.authorizationService);
  Future<void> LogIn() async {
    try {
      _logIn = true;
      notifyListeners();
      await authorizationService.authorize();
    } finally {
      _logIn = false;
      notifyListeners();
    }
  }
}

Future<http.Response> login(String mobileNo, String pinNo, String idNumber, String uniqueId, String saccoId, String verificationCode, String location, String imsi, String model, String simOperator, String networkState, String simTel) {
    return http.post(
      Uri.parse('https://suresms.co.ke:3438/api/AppLogins'),
      headers: <String, String>{
        'Token': 'c76189858f8a4f1a72f8bb4193e90823f9fb2581032b6c838aac6dcf7aff966d',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        '37359946': idNumber,
        '6556565': uniqueId,
        '00048': saccoId,
        '969628': verificationCode,
        'KIL': location,
        'IME34566': imsi,
        '5299': pinNo,
        'BUNDY': model,
        'SAF': simOperator,
        'SIM DATA': networkState,
        '254740481483': simTel,
        '+254740481483': mobileNo
      }),
    );
  }

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var errorMsg;
  final formKey = new GlobalKey<FormState>();
  late String _pin, _login;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  bool _isLoading = false;
  final TextEditingController pinController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return Scaffold(
      //appBar: AppBar(
        //title: Text(config!.appDisplayName),
      //),
      //body: _buildBody(config.appInternalId),
    );
  }

  Widget _buildBody(String appName, int appInternalId) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            radius: 56.0,
            child: Image.asset('assets/' + appInternalId.toString() + '/icon.png'),
          )
      ),
    );


    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        key: formKey,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        controller: pinController,
        onSaved: (value) => _pin = value!,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'CloudPESA Pin is required';
          }
          else return null;
        },
        decoration: InputDecoration(
            labelText: 'CloudPESA Pin',
            labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                )
            ),
            hintText: '****',
            hintStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                )
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            )
        ),
      ),
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text("Forgot password?",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w300
            )
          )
        ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text('Login',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )
              )
          ),
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          onPressed: () {
            _isLoading = true;
            setState(() {
              CircularProgressIndicator();
            });
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
            // ignore: unnecessary_null_comparison
          },
        ),
      ),
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        auth.loggingIn(_pin, _login,_pin, _login,_pin, _login,_pin, _login,_pin, _login,_pin, _login,);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                logo,
                inputPassword,
                //buttonLogin,
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Login", doLogin),
                SizedBox(height: 5.0),
                forgotLabel
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.atm),
                  label: 'Coop ATM'
              ),
              new BottomNavigationBarItem(
                icon: new Icon(FontAwesomeIcons.calculator),
                label: 'Loan Calc',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Find Us',
              )
            ],
          ),
        )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

