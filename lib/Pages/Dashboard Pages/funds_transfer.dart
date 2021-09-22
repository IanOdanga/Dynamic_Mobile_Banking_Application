import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/common.dart';

class FundsTransfer extends StatefulWidget {
  @override
  _FundsTransferState createState() => _FundsTransferState();
}
class _FundsTransferState extends State<FundsTransfer> {
  double money = 50.00;
  final sendController = TextEditingController();
  final recipientController = TextEditingController();
  final sourceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funds Transfer',
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        backgroundColor: Colors.white,
      ),
        backgroundColor: white,
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.cyan.shade200,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60),)
                ),
              ),
              SafeArea(
                child: ListView(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "\nTotal Balance\n", style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text: "\K\s\h ", style: TextStyle(color: Colors.black, fontSize: 30)),
                                TextSpan(text: "11,991.00 \n", style: TextStyle(color: Colors.black, fontSize: 36)),
                                TextSpan(text: "\nFunds Transferred by Mpesa\n", style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text: "\K\s\h ", style: TextStyle(color: Colors.black, fontSize: 30)),
                                TextSpan(text: "36,444.00 \n", style: TextStyle(color: Colors.black, fontSize: 36)),
                                TextSpan(text: "\nFunds Transferred Last Month\n", style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text: "\K\s\h ", style: TextStyle(color: Colors.black, fontSize: 30)),
                                TextSpan(text: "22,545.00 \n", style: TextStyle(color: Colors.black, fontSize: 36)),
                              ]
                          )),
                        ),
                        IconButton(icon: Icon(Icons.more_vert, color: white,size: 40,), onPressed: (){})
                      ],
                    ),

                    SizedBox(height: 5,),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Send money"),
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
                            backgroundColor: Colors.cyan.shade200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(backgroundImage: AssetImage("images/p2.jpg"),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(backgroundImage: AssetImage("images/p3.jpg"),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(backgroundImage: AssetImage("images/p1.jpg"),),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Recent transactions"),
                        ),
                      ],
                    ),

                    ListTile(
                      onTap: (){
                        _settingModalBottomSheet(context);
                      },
                      leading: CircleAvatar(backgroundImage: AssetImage("images/p3.jpg"),),
                      title: RichText(text: TextSpan(children: [
                        TextSpan(text: 'Normal Account\n'),
                        TextSpan(text: 'Money Sent - 12th August 9AM', style: TextStyle(fontSize: 14, color: grey))
                      ], style: TextStyle(color: Colors.black, fontSize: 18))),
                      trailing: Text("- \K\s\h. 6277", style: TextStyle(fontSize: 20),),
                    ),

                    ListTile(
                      onTap: (){
                        _settingModalBottomSheet(context);
                      },
                      leading: CircleAvatar(backgroundImage: AssetImage("images/p2.jpg"),),
                      title: RichText(text: TextSpan(children: [
                        TextSpan(text: 'Holiday Account\n'),
                        TextSpan(text: 'Money received - 11th August 12PM', style: TextStyle(fontSize: 14, color: grey))
                      ], style: TextStyle(color: Colors.black, fontSize: 18))),
                      trailing: Text("+ \K\s\h. 5350", style: TextStyle(fontSize: 20),),
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
                  child: Text("Amount to send",
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
                      controller: sendController,
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
                  padding: EdgeInsets.only(bottom: 7),
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
                  child: Text("Destination Account",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black87,
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 7),
                  alignment: Alignment.center,
                  child: TextFormField(
                      controller: recipientController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                    SizedBox(width: 10,),
                    Text('Transfer Ksh. ${sendController.text}from ${sourceController.text} to ${recipientController.text}', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
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
                          child: Text("Send Money", style: TextStyle(
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