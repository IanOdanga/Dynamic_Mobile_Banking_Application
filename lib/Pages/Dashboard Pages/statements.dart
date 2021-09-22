import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/Pages/Login/Auth.dart';
import 'package:untitled/src/util/widgets.dart';

class DataService {
  Future<http.Response> getAllLoans(String mobileNo) {
    return http.post(
      Uri.parse('https://suresms.co.ke:3438/api/MobileGetAllLoans'),
      headers: <String, String>{
        'Token': 'c76189858f8a4f1a72f8bb4193e90823f9fb2581032b6c838aac6dcf7aff966d',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        '+254740481483': mobileNo
      }),
    );
  }
}

class StatementList {
  late int principleAmount;
  late int outstandingBalance;
  late int outstandingInterest;
  late int totalAmount;
  late String loanNo;
  late String loanStatus;
  Null name;
  late String loanProductName;
  late String loanType;
  late String transType;

  StatementList(
      {required this.principleAmount,
        required this.outstandingBalance,
        required this.outstandingInterest,
        required this.totalAmount,
        required this.loanNo,
        required this.loanStatus,
        this.name,
        required this.loanProductName,
        required this.loanType,
        required this.transType});

  StatementList.fromJson(Map<String, dynamic> json, this.principleAmount, this.outstandingBalance, this.outstandingInterest, this.totalAmount, this.loanNo, this.loanStatus, this.loanProductName, this.loanType, this.transType) {
    principleAmount = json['principle_amount'];
    outstandingBalance = json['outstanding_balance'];
    outstandingInterest = json['outstanding_interest'];
    totalAmount = json['total_amount'];
    loanNo = json['loan_no'];
    loanStatus = json['loan_status'];
    name = json['name'];
    loanProductName = json['loan_product_name'];
    loanType = json['loan_type'];
    transType = json['trans_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['principle_amount'] = this.principleAmount;
    data['outstanding_balance'] = this.outstandingBalance;
    data['outstanding_interest'] = this.outstandingInterest;
    data['total_amount'] = this.totalAmount;
    data['loan_no'] = this.loanNo;
    data['loan_status'] = this.loanStatus;
    data['name'] = this.name;
    data['loan_product_name'] = this.loanProductName;
    data['loan_type'] = this.loanType;
    data['trans_type'] = this.transType;
    return data;
  }
}

class StatementsPage extends StatefulWidget {
  StatementsPage({Key? key}) : super(key: key);

  @override
  _StatementsPageState createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {

  final formKey = new GlobalKey<FormState>();
  final _memberNoController = TextEditingController();
  final _idNoController = TextEditingController();
  final _dataService = DataService();
  late StatementList _response;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final FlutterSecureStorage flutterSecureStorage;
    appBar: AppBar(
      title: Text('Statements',
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              )
          )
      ),
      backgroundColor: Colors.white,
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Loading ...")
      ],
    );
    final inputPhoneNumber = Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
        width: 150,
        child: TextField(
            controller: _memberNoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Phone Number',
              labelStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                  )
              ),
            ),
            textAlign: TextAlign.center),
      ),
    );
    final inputIDNumber = Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: 150,
        child: TextField(
            controller: _idNoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'ID Number',
              labelStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black,
                  )
              ),
            ),
            textAlign: TextAlign.center),
      ),
    );
    var getLoans = () {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        DataService() as Future<Map<String, dynamic>>;

        successfulMessage.then((response) {
          if (response['status']) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed to load Loans",
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
                inputPhoneNumber,
                inputIDNumber,
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Get BOSA Statements", getLoans),
                SizedBox(height: 5.0),
              ],
            ),
          ),
        )
    );
  }
  void _search() async {
    CircularProgressIndicator();
    final response = await _dataService.getAllLoans(_memberNoController.text,);
    setState(() => _response = response as StatementList);
  }
}