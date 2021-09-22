import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Pages/Dashboard%20Pages/ReachUs.dart';
import 'package:untitled/Pages/Dashboard%20Pages/cash_withdrawals.dart';
import 'package:untitled/Pages/Dashboard%20Pages/deposits.dart';
import 'package:untitled/Pages/Dashboard%20Pages/funds_transfer.dart';
import 'package:untitled/Pages/Dashboard%20Pages/feedback.dart';
import 'package:untitled/Pages/Dashboard%20Pages/loanspage.dart';
import 'package:untitled/Pages/Dashboard%20Pages/statements.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Welcome' ,
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    )
                  )
          ),
            decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/icon.png'))),
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Deposits',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => DepositsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.moneyCheck),
            title: Text('Loans',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => LoansPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.compare_arrows),
            title: Text('Funds Transfer',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
            Navigator.push(
              context,MaterialPageRoute(builder: (context) => FundsTransfer()),
            );
          },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            title: Text('Cash Withdrawals',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => CashWithdrawals()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Statements',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => StatementsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Feedback',
                style: GoogleFonts.lato(
                )
            ),
            onTap:() {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => ReachUs()),
              );
            },
          ),
        ],
      ),
    );
  }
}