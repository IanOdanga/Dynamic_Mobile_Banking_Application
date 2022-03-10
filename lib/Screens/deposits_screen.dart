import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'dart:async';
import 'package:untitled/common.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey("Wo7rTAza4USEDomxYuP53AgFFtoQYa9Z");
  MpesaFlutterPlugin.setConsumerSecret("ZHoN8xilr83RFsAN");
}

class DepositsPage extends StatefulWidget{
  static const String idScreen = "deposits";
  @override
  _DepositsPageState createState() => _DepositsPageState();
}

enum DepositFrom { MPesa, Bank }

class _DepositsPageState extends State<DepositsPage>{
  DepositFrom? _depositFrom = DepositFrom.MPesa;

  final myController = TextEditingController();
  final radioController = TextEditingController();

  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: 1.0,
          partyA: "254740481483",
          partyB: "600000",
//Lipa na Mpesa Online ShortCode
          callBackURL: Uri(scheme: "https",
              host: "mpesa-requestbin.herokuapp.com",
              path: "/vvy1uhvv"),

          accountReference: "Umoja Wendani Sacco",
          phoneNumber: "254740481483",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "paybill",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      return transactionInitialisation;
    }

    catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit',
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60),)
              ),
            ),
            SafeArea(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 5,),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Deposit money to your account? \nPress here",
                            style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )
                            )
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            child: new IconButton(
                              icon: new Icon(Icons.add,),
                              onPressed:(){
                                _settingModalBottomSheet(context);
                              },
                            ),
                            radius: 25,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Recent transactions",
                            style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                )
                            )
                        ),
                      ),
                    ],
                  ),

                  ListTile(
                    onTap: (){
                      _settingModalBottomSheet(context);
                    },
                    title: RichText(text: TextSpan(children: [
                      TextSpan(text: 'Money Deposited - Today 9AM', style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black)))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                    trailing: Text("+ \K\s\h. 52530", style: TextStyle(fontSize: 20),),
                  ),

                  ListTile(
                    onTap: (){
                      _settingModalBottomSheet(context);
                    },
                    title: RichText(text: TextSpan(children: [
                      TextSpan(text: 'Money Deposited - Today 12PM', style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black)))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                    trailing: Text("+ \K\s\h. 3330", style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    white,

                    white.withOpacity(0.1),

                  ])
          ),
          height: 50,
        )
   );
  }

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), topLeft: Radius.circular(20))
            ),
            child: new Wrap(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  , children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ],),
                Container(
                  alignment: Alignment.center,
                  child: Text("Amount to deposit",
                      style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.black87,
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                      controller: myController,
                      textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Enter MPesa Phone Number",
                      style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.black87,
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                    SizedBox(width: 10,),
                    Text('Deposit Ksh. ${myController.text} from MPesa', style: GoogleFonts.raleway(
                      textStyle: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      lipaNaMpesa();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("Deposit Money", style: GoogleFonts.raleway(
                            textStyle: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}