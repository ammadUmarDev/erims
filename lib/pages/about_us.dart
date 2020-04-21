import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:erims/components/bodyText.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/h1.dart';
import 'package:erims/components/h3.dart';
import 'package:erims/components/textFieldErims.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../components/interTextFieldSpacing.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFee8572),
              Color(0xFF35495e),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "E.R.I.M.S",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Event Registeration and Information Management System",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 14,
                              color: Color(0xFF35495e),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Image.asset('assets/logos/nucsw.png'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.asset('assets/logos/sv.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ListView(
                    children: <Widget>[
                      H1(textBody: "Get to know us"),
                      InterTextFieldSpacing(),
                      BodyText(
                          textBody:
                              "Welcome to Suivantec®. We provide intelligent solutions to unlock new possibilities. Together, we can bring your ideas to life so reach out for a new project."),
                      InterTextFieldSpacing(),
                      H1(textBody: "What is E.R.I.M.S ® ?"),
                      InterTextFieldSpacing(),
                      BodyText(
                          textBody:
                              "Event Registeration and Information Management System by Suivantec®, built in collaboration with National University Computing Society."),
                      InterTextFieldSpacing(),
                      H1(textBody: "Contact us"),
                      InterTextFieldSpacing(),
                      BodyText(
                          textBody:
                              "Send your queries at erims.suivantec@gmail.com"),
                      BodyText(
                          textBody:
                              "Reach out to Suivantec® at suivantec.contact@gmail.com"),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
