import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> sendVerificationCode(String mobileNo, String idNumber, String uniqueId, String saccoId) {
  return http.post(
    Uri.parse('https://suresms.co.ke:3438/api/SendVerificationCode'),
    headers: <String, String>{
      'Token': '',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '37359946': idNumber,
      '+254740481483': mobileNo,
      '6556565': uniqueId,
      '00048': saccoId
    }),
  );
}