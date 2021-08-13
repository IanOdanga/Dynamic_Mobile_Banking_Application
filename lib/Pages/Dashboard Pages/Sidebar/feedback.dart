import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBack extends StatefulWidget{
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedBack>{
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMail() async {
    const url =
        'mailto:iluke@cloudpesaea.com?subject=UmojaWendaniApp&body=Your suggestions%20or Feedback..';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  late String name;
  late String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Feedback',
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              child: Text(
                "Leave us a message, and we'll get in contact with you as soon as possible. ",
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                    )
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) name = val;
                },
                controller: t1,
                decoration: InputDecoration(
                  fillColor: Color(0xffffff),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Your name',
                  hintStyle: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                      )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) message = val;
                },
                textAlign: TextAlign.start,
                controller: t2,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  hintText: 'Your message',
                  hintStyle: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.black,
                      )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              color: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    t1.clear();
                    t2.clear();
                    launchUrl(
                        "mailto:iluke@cloudpesaea.com?subject=From $name&body=$message");
                  });
                },
                child: ListView(
                  prototypeItem: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                            "Send",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                )
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Alternatively, you can also report bugs and errors on following platforms",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      height: 0.8,
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  //  onTap: () => launchUrl(
                  //    ""),
                  child: Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  // onTap: () => _launchURLMail(),
                  child: Icon(FontAwesomeIcons.at,
                      color: Color(0xff1DA1F2), size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}