import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/image2.png',
    title: 'CloudPESA',
    description: 'The most Agile, Dynamic Mobile Banking Solution.',
  ),
  Slide(
    imageUrl: 'assets/image1.png',
    title: 'Withdraw, Deposit and Transfer Funds',
    description: 'Transfer funds from your account to MPESA and from MPESA to your account',
  ),
  Slide(
    imageUrl: 'assets/image3.png',
    title: 'ATM and Branches',
    description: 'Locate nearest ATM or Branch.',
  ),
];