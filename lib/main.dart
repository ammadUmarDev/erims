import 'package:erims/pages/create_event.dart';
import 'package:erims/pages/dashboard.dart';
import 'package:erims/pages/event_calender.dart';
import 'package:erims/pages/home.dart';
import 'package:erims/pages/sign_in.dart';
import 'package:erims/pages/sign_up.dart';
import 'package:erims/test.dart';
import 'package:flutter/material.dart';
import 'pages/confirm_create_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERIMS',
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      theme: ThemeData(
        //peach : Color(0xFFee8572)
        //blue : Color(0xFF35495e)
        primaryColor: Color(0xFF35495e),
        accentColor: Color(0xFFee8572),
      ),
      routes: {
        "test": (context) => Test(),
        "home": (context) => Home(),
        "signIn": (context) => SignIn(),
        "signUp": (context) => SignUp(),
        "dashBoard": (context) => DashBoard(),
        "createEvent": (context) => CreateEvent(),
        "confirmCreateEvent": (context) => ConfirmCreateEvent(),
        "eventCalendar": (context) => EventCalender(),
      },
    );
  }
}
