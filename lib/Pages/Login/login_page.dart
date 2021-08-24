import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Pages/Dashboard Pages/Dashboard.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
export 'package:untitled/Providers/Auth.dart';
export 'package:untitled/src/models/login_user_type.dart';
export 'package:untitled/src/providers/login_messages.dart';
export 'package:untitled/src/providers/login_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Widgets/placeholder_widget.dart';
import '../../Services/authorization_service.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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

Future<Body> fetchLoginData() async {
  final response = await http.get(
    Uri.parse('https://suresms.co.ke:3438/api/AppLogins'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: '23869088b480445f66ba29f452312eea38f27e84ed8fbc9288d67ddb82e04ae8',
    },
  );
  final responseJson = jsonDecode(response.body);

  return Body.fromJson(responseJson);
}

class Body {
  final String mobileNo;
  final int pinNo;
  final String idNumber;
  final int uniqueId;
  final String saccoId;
  final int verificationCode;
  final String location;
  final int imsi;
  final int model;
  final String simOperator;
  final int networkState;
  final String simTel;

  Body({
    required this.mobileNo,
    required this.pinNo,
    required this.idNumber,
    required this.uniqueId,
    required this.saccoId,
    required this.verificationCode,
    required this.location,
    required this.imsi,
    required this.model,
    required this.networkState,
    required this.simOperator,
    required this.simTel
});
  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
        idNumber: json['37359946'],
        uniqueId: json['6556565'],
        saccoId: json['00048'],
        verificationCode: json['5299'],
        location: json['KIL'],
        imsi: json['IME34566'],
        pinNo: json['5299'],
        model: json['BUNDY'],
        simOperator: json['SAF'],
        networkState: json['Sim Data'],
        simTel: json['254740481483'],
        mobileNo: json['254740481483']
    );
  }

  Future <Body> login(http.Client client) async {
    final response = await client
        .post(Uri.parse('https://suresms.co.ke:3438/api/MobileGetAllLoans'));

    return compute(parseLoginBody, response.body);
  }

  Future <Body> parseLoginBody(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Body>((json) => Body.fromJson(json)).toList();
  }

}
class LoginPage extends StatefulWidget {
  static const String routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (isSupported) =>
          setState(() =>
          _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
    );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
            () =>
        _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  var errorMsg;
  final formKey = new GlobalKey<FormState>();
  late String _pin;

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
    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            radius: 56.0,
            child: Image.asset('assets/logo.png'),
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

    logIn(String pin) async {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      Map data = {
        'Pin': pin
      };
      var jsonResponse;
      var response = await http.post(
          Uri.https('suresms.co.ke:3438/api/', 'AppLogins'), body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          sharedPreferences.setString("token",
              jsonResponse['d917b18e0e564e8fcd60046ad9c93d78e485c100ca39d1de50af26399ccf4d54']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => Dashboard()), (
              Route<dynamic> route) => false);
        }
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }
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
            CircularProgressIndicator();
            _isLoading = true;
            setState(() {
              _isLoading = true;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Authenticating ... Please wait')));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Dashboard()));
            });
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
            logIn(pinController.text);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
            // ignore: unnecessary_null_comparison
          },
        ),
      ),
    );
    //body: _children[_currentIndex];
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                logo,
                inputPassword,
                loading,
                buttonLogin,
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

  signIn(String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse('https://suresms.co.ke:3438/api/AppLogins'), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['data']['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()), (
            Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}

