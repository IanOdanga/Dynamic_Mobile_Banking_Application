import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Pages/Login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Services/authorization_service.dart';
import 'package:untitled/Pages/Welcome/getting_started.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  var activated;
  var phoneNumber;
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
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    activated(String phoneNumber) async {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      Map data = {
        'phoneNumber': phoneNumber
      };
      var jsonResponse;
      var response = await http.post(
          Uri.https('suresms.co.ke:3438/api/', 'VerifyPhoneNumber'), body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          //setState(() {
          //  _isLoading = false;
        //  }//);
          sharedPreferences.setString("token",
              jsonResponse['d917b18e0e564e8fcd60046ad9c93d78e485c100ca39d1de50af26399ccf4d54']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()), (
              Route<dynamic> route) => false);
        }
      }
      else {
        //setState(() {
         // _isLoading = false;
        //});
        print(response.body);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('ACTIVATION',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
            )
        ),
        elevation: 0,
        backgroundColor: HexColor("#1EC9BD"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GettingStartedScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            //color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      height: 130,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                      /*decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Phone Number',
                        hintStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.black,
                          )
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      */
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                              )
                          ),
                          hintText: 'Enter Phone Number',
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
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      height: 56,
                      child: Text(
                        'Activate',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                          fontSize: 20,
                          )
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                         // borderSide: BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(50)
                    ),
                      padding: EdgeInsets.only(bottom: 5),
                      textColor: Colors.black,
                      onPressed: () {
                        if (phoneNumber == activated){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Successfully Activated! You can now access CloudPesa services',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      )
                                    ),
                                  )));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('It seems you are not registered for CloudPesa services.\n Register for CloudPesa in order to access services',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                        )
                                      ),
                                    )
                                )
                            );
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}