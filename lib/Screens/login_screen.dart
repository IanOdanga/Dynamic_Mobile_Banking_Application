import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
export 'package:untitled/src/models/login_user_type.dart';
export 'package:untitled/src/providers/login_messages.dart';
export 'package:untitled/src/providers/login_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Model/TokenModel.dart';
import 'package:untitled/Model/user_model.dart';
import 'package:untitled/Screens/pin_verification_screen.dart';
import 'package:untitled/Services/settings.dart';
import 'package:untitled/Services/storage.dart';
import 'package:untitled/Widgets/app_config.dart';
import 'package:untitled/Widgets/placeholder_widget.dart';
import 'package:untitled/Widgets/progress_dialog.dart';
import 'package:flutter/services.dart';
import '../main_common.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  static const String idScreen = "login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? errorMessage;
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();

  late String telephone;
  late String password;

  late Future myFuture;

  @override
  void initState() {
    myFuture = getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return Scaffold(
      //appBar: AppBar(
      //title: Text(config!.appDisplayName),
      //),
      body: _buildBody(/*config!.appInternalId*/),
    );
  }

  Widget _buildBody(/*String appInternalId*/) {
    final usernameField = TextFormField(
      autofocus: false,
      controller: telephoneController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Phone Number");
        }
        return null;
      },
    /*onSaved: (value) {
          agentcodeController.text = value!;
        },*/
      onSaved: (input) => telephone = input!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(FontAwesomeIcons.phone),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Phone Number",
        hintStyle: const TextStyle(fontFamily: "Brand Bold"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.number,
      validator: (value) {
      RegExp regex = RegExp(r'^.{4,}$');
      if (value!.isEmpty) {
      return ("Password is required for login");
      }
      if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 4 Character)");
        }
      },
    /*onSaved: (value) {
          passwordController.text = value!;
        },*/
      onSaved: (input) =>
      password = input!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: const TextStyle(fontFamily: "Brand Bold",),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          ),
      ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromRGBO(15,175,231,1),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(message: "Authenticating...");
            }
          );
          if (telephoneController.text.isEmpty){
          showPhoneDialog(context);
          }
          else if (passwordController.text.isEmpty){
          showPassDialog(context);
          }
          else if (telephoneController.text.isEmpty && passwordController.text.isEmpty){
          showAlertDialog(context);
          }
          else {
            getToken();
            //sendVerificationCode(telephoneController.text);
            }
          },
          child: const Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 20, color: Colors.white, fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
            )),
          );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/umoja/icon.png",
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 45),
                      usernameField,
                      const SizedBox(height: 25),
                      passwordField,
                      const SizedBox(height: 35),
                      loginButton,
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          )
      );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  displayToastMessage(String errorMessage, BuildContext context){
    Fluttertoast.showToast(msg: errorMessage);
  }

  showPhoneDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Ok", style: TextStyle(fontFamily: "Brand Bold"),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Failed", style: TextStyle(fontFamily: "Brand Bold"),),
      content: const Text("Phone Number cannot be Empty!", style: TextStyle(fontFamily: "Brand Bold"),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPassDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Ok", style: TextStyle(fontFamily: "Brand Bold"),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Failed", style: TextStyle(fontFamily: "Brand Bold"),),
      content: const Text("Password cannot be Empty!", style: TextStyle(fontFamily: "Brand Bold"),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Ok", style: TextStyle(fontFamily: "Brand Bold"),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Failed", style: TextStyle(fontFamily: "Brand Bold"),),
      content: const Text("Phone Number or Password cannot be Empty!", style: TextStyle(fontFamily: "Brand Bold"),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final resp = apiDetails();
    final username = prefs.getString('Username') ?? '';
    final password = prefs.getString('Password') ?? '';
    final response= await http.get(
      Uri.parse("https://suresms.co.ke:4242/mobileapi/api/GetToken"),
      headers: {
        "Username": username,
        "Password": password,
        "Accept": "application/json"
      }
    );
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty)
      {
        Map<String, dynamic>res = jsonDecode(response.body);
        //print(response.body);
        print(res['Token']);
        String? authToken = res['Token'];
        final SecureStorage secureStorage = SecureStorage();
        secureStorage.writeSecureToken('Token', authToken!);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('Token', res['Token']);

        sendVerificationCode(telephoneController.text);
        
      } else {
        Fluttertoast.showToast(msg: "No Transactions were found!");
      }
    } else {
      Fluttertoast.showToast(msg: "Please try again!");
    }
    return TokenModelResponse.fromJson(json.decode(response.body));
  }

  sendVerificationCode(mobileNo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? '';
    print(token);
    Map data = {
      "mobile_no": mobileNo
    };
    //print(data.toString());
    print(data);
    final response= await http.post(
      Uri.parse("https://suresms.co.ke:4242/mobileapi/api/SendVerificationCode"),
      headers: {
        "Accept": "application/json",
        "Token": token
      },
      body: json.encode(data),
      //encoding: Encoding.getByName("utf-8")
    );
    if (response.request != null ) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(message: "Authenticating...");
          }
      );
    }
    prefs.setString('telephone', mobileNo);

    final SecureStorage secureStorage = SecureStorage();
    secureStorage.writeSecureToken('Telephone', mobileNo);

    setState(() {
      isLoading=false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String,dynamic>res=jsonDecode(response.body);
      print(response.body);
      Navigator.push(context, PageTransition(type: PageTransitionType.rotate, alignment: Alignment.bottomCenter, duration: Duration(seconds: 1), child: PinCodeVerificationScreen(mobileNo)));

      //Fluttertoast.showToast(msg: "Login Successful");

    } else {
      Map<String,dynamic>res=jsonDecode(response.body);
      Fluttertoast.showToast(msg: "${res['Description']}");
    }
  }
}
