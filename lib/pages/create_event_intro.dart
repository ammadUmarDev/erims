import 'package:erims/components/bodyText.dart';
import 'package:erims/components/h1.dart';
import 'package:erims/components/navigatorButtonBlue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventIntro extends StatefulWidget {
  @override
  _CreateEventIntroState createState() => _CreateEventIntroState();
}

class _CreateEventIntroState extends State<CreateEventIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            H1(textBody: "Create an Event"),
            SizedBox(height: 10),
            BodyText(
              textBody:
                  "Please enter valid and concise information. Your event request will be forwarded to selected mentor. Upon approval you will be notified and your event will be added to event feed.",
              align: TextAlign.center,
            ),
            SizedBox(height: 30),
            NavigatorButtonBlue(
              buttonText: "PROCEED",
              navigateTo: "createEvent",
            ),
          ],
        ),
      ),
    );
  }
}
