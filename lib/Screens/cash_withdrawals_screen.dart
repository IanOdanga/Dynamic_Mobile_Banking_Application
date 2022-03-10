import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:untitled/common.dart';

enum WithdrawTo { MPesa, Bank }

class CashWithdrawals extends StatefulWidget{
  static const String idScreen = "withdraw";
  @override
  _CashWithdrawalsState createState() => _CashWithdrawalsState();
}

class _CashWithdrawalsState extends State<CashWithdrawals>{
  //WithdrawTo? _withdrawTo = WithdrawTo.MPesa;
  double money = 5000;
  final myController = TextEditingController();
  final sourceController = TextEditingController();
  final radioController = TextEditingController();

  late String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Withdrawals',
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
                        child: Text("Withdraw money from your account? \nPress here",
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
                      TextSpan(text: 'Money Withdrawn - Yesterday 5.30PM', style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black)))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                    trailing: Text("- \K\s\h. 39292", style: TextStyle(fontSize: 20),),
                  ),

                  ListTile(
                    onTap: (){
                      _settingModalBottomSheet(context);
                    },
                    title: RichText(text: TextSpan(children: [
                      TextSpan(text: 'Money Withdrawn - Today 10AM', style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black)))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                    trailing: Text("- \K\s\h. 7965", style: TextStyle(fontSize: 20),),
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
                  child: Text("Amount to withdraw",
                      style: GoogleFonts.lato(
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
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Source Account",
                      style: GoogleFonts.lato(
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
                      controller: sourceController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Where do you want to withdraw to?",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black87,
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child:DropdownButton<String>(
                    focusColor:Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.white,)),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      'MPesa',
                      'Bank',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.white,)),),
                      );
                    }).toList(),
                    hint:Text(
                      "Please choose",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.white,)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value!;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                    SizedBox(width: 10,),
                    Text('Withdraw Ksh. ${myController.text} from ${sourceController.text} to ${radioController.text}', style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),),
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
                      Navigator.pop(context);
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
                          child: Text("Withdraw Money", style: TextStyle(
                              fontSize: 22, color: Colors.white),),
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