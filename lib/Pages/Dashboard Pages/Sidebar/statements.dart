import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<statement_list> fetchLoanStatements() async {
  final response = await http.get(
    Uri.parse('https://suresms.co.ke:3438/api/MobileLoanStatement'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: '3d3e7e331346fa1a531388e5f5461392621eeeb04cfeb2ffce9ed13e5c07e318',
    },
  );
  final responseJson = jsonDecode(response.body);

  return statement_list.fromJson(responseJson);
}

class statement_list {
  final String mobile_no;

  statement_list({
    required this.mobile_no,
  });

  factory statement_list.fromJson(Map<String, dynamic> json) {
    return statement_list(
      mobile_no: json['+254740481483'],
    );
  }
}
Future<List<statement_list>> fetchLoans(http.Client client) async {
  final response = await client
      .post(Uri.parse('https://suresms.co.ke:3438/api/MobileLoanStatement'));

  return compute(parseLoanStatement, response.body);
}

List<statement_list> parseLoanStatement(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<statement_list>((json) => statement_list.fromJson(json)).toList();
}

class StatementsPage extends StatefulWidget {
  StatementsPage({Key? key}) : super(key: key);

  @override
  _StatementsPageState createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  late Future<statement_list> futureLoanStatements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Statements',
        style: GoogleFonts.raleway(
        textStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
              )
            )
          ),
        ),
      body: FutureBuilder<List<statement_list>>(
        future: fetchLoans(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            print(snapshot.error);
          return snapshot.hasData
              ? Loanstatement(statementlist: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
class Loanstatement extends StatelessWidget {
  final List<statement_list> statementlist;

  Loanstatement({Key? key, required this.statementlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: statementlist.length,
      itemBuilder: (context, index) {
        return Image.network(statementlist[index].mobile_no);
      },
    );
  }
}