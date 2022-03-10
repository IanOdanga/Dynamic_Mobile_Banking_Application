import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';

class Updates extends StatefulWidget {
  static const String idScreen = "legal";
  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Check for Updates',
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
              )
          ),
          backgroundColor: Colors.cyan.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text('App version: v1.0.0.0',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )
                    )),
              ),
              ElevatedButton(
                child: Text('Check for Update',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )
                    )
                ),
                onPressed: () => checkForUpdate(),
              ),
              ElevatedButton(
                child: Text('Perform immediate update',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )
                    )
                ),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.performImmediateUpdate()
                      .catchError((e) => showSnack(e.toString()));
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Start flexible update',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )
                    )
                ),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.startFlexibleUpdate().then((_) {
                    setState(() {
                      _flexibleUpdateAvailable = true;
                    });
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Complete flexible update',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )
                    )
                ),
                onPressed: !_flexibleUpdateAvailable
                    ? null
                    : () {
                  InAppUpdate.completeFlexibleUpdate().then((_) {
                    showSnack("Success!");
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                },
              )
            ],
          ),
        ),
    );
  }
}