import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            buildMenuItem(Icons.account_balance, "DEPOSITS",
              Style: GoogleFonts.lato(
                textStyle: TextStyle(
                )
            ),
                opacity: 1.0, color: Colors.cyan.shade200,),
            Divider(),
            buildMenuItem(Icons.compare_arrows, "FUNDS TRANSFER",
              Style: GoogleFonts.lato(
                textStyle: TextStyle(
                )
            ),
            ),
            Divider(),
            buildMenuItem(Icons.receipt, "STATEMENTS",
              Style: GoogleFonts.lato(
                textStyle: TextStyle(
                )
            ),
            ),
            Divider(),
            buildMenuItem(Icons.attach_money, "LOANS",
              Style: GoogleFonts.lato(
                  textStyle: TextStyle(
                  )
              ),
            ),
            Divider(),
            buildMenuItem(Icons.account_balance_wallet_outlined, "CASH WITHDRAWALS",
              Style: GoogleFonts.lato(
                  textStyle: TextStyle(
                  )
              ),
            ),
            Divider(),
            buildMenuItem(Icons.phone, "FEEDBACK",
              Style: GoogleFonts.lato(
                  textStyle: TextStyle(
                  )
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Opacity buildMenuItem(IconData icon, String title,
      {double opacity = 0.3, Color color = Colors.black, Style}) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Icon(
              icon,
              size: 50.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}