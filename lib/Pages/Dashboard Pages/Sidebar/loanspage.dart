import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:untitled/Services/authorization_service.dart';

class DataService {
  Future<LoanResponse> getLoans(String phoneNumber, String idNumber) async {
    final queryParameters = {
      'mobile_no': '+254740481483',
    };

    final uri = Uri.https(
        'suresms.co.ke:3438/api/', 'MobileGetAllLoans', queryParameters);

    final response = await http.get(uri,
      headers: {
        HttpHeaders.authorizationHeader: 'accessToken',
      },
    );
    print(response.body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(json.decode(response.body));
    } else {
      print(response.statusCode);
    }
    return LoanResponse.fromJson(json);
  }
}

class LoanInfo {
  final String name;
  final String memberNo;
  final String idNo;
  final String mobileNo;

  LoanInfo({
    required this.name,
    required this.memberNo,
    required this.idNo,
    required this.mobileNo,
  });

  factory LoanInfo.fromJson(Map<String, dynamic> json) {
    final name = json['Name'];
    final memberNo = json['Member No.'];
    final idNo = json['ID No.'];
    final mobileNo = json['Mobile No.'];
    return LoanInfo(
      name: name,
      memberNo: memberNo,
      idNo: idNo,
      mobileNo: mobileNo,
    );
  }
}

class Loanlist {
  final double principleAmount;
  final double outstandingBalance;
  final double outstandingInterest;
  final double totalAmount;
  final String loanNo;
  final String loanProductName;
  final String loanType;
  final String loanStatus;

  Loanlist({
    required this.principleAmount,
    required this.outstandingBalance,
    required this.outstandingInterest,
    required this.totalAmount,
    required this.loanNo,
    required this.loanProductName,
    required this.loanType,
    required this.loanStatus
  });

  factory Loanlist.fromJson(Map<String, dynamic> json) {
    final principleAmount = json['Principle amount'];
    final outstandingBalance = json['Outstanding balance'];
    final outstandingInterest = json['Outstanding interest'];
    final totalAmount = json['Total amount'];
    final loanNo = json['Loan no'];
    final loanProductName = json['Loan product name'];
    final loanType = json['Loan type'];
    final loanStatus = json['Loan status'];
    return Loanlist(
      principleAmount: principleAmount,
      outstandingBalance: outstandingBalance,
      outstandingInterest: outstandingInterest,
      totalAmount: totalAmount,
      loanNo: loanNo,
      loanProductName: loanProductName,
      loanType: loanType,
      loanStatus: loanStatus,
    );
  }
}

class LoanResponse {
  late final String loanType;
  late final Loanlist loanlist;
  late final LoanInfo loanInfo;

  LoanResponse({
    required this.loanType,
    required this.loanlist,
    required this.loanInfo
  });

  factory LoanResponse.fromJson(Map<String, dynamic> json) {
    final loanType = json['name'];

    final loanlistJson = json['loan list'];
    final loanlist = Loanlist.fromJson(loanlistJson);

    final loanInfoJson = json['loan info'][0];
    final loanInfo = LoanInfo.fromJson(loanInfoJson);

    return LoanResponse(
        loanType: loanType, loanlist: loanlist, loanInfo: loanInfo);
  }
}

class LoansPage extends StatefulWidget{
  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  LoanResponse? _response;

  final _memberNoController = TextEditingController();
  final _idNoController = TextEditingController();
  final _dataService = DataService();


    @override
    Widget build(BuildContext context) {
      final FlutterSecureStorage flutterSecureStorage;
      return Scaffold(
        appBar: AppBar(
          title: Text('Loans',
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  )
              )
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_response != null)
                Column(
                  children: [
                    Text(_response!.loanInfo.name),
                    Text(_response!.loanInfo.memberNo),
                    Text(_response!.loanInfo.idNo),
                    Text(_response!.loanInfo.mobileNo),
                    Text(
                      '${_response!.loanlist.principleAmount}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.outstandingBalance}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.outstandingInterest}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.totalAmount}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.loanNo}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.loanProductName}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.loanType}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '${_response!.loanlist.loanStatus}°',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(_response!.loanInfo.name)
                  ],
                ),
              Padding(
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
              ),
              Padding(
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
              ),
              ElevatedButton(onPressed: _search, child: Text('Get Loans',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                    )
                  ),
                )
              )
            ],
          ),
        ),
      );
    }
  void _search() async {
      CircularProgressIndicator();
    final response = await _dataService.getLoans(_memberNoController.text, _idNoController.text);
    setState(() => _response = response);
  }
}
