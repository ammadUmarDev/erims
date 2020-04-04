import 'package:erims/components/navigatorButtonWhite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//peach : Color(0xFFee8572)
//blue : Color(0xFF35495e)

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  @override
  Widget build(BuildContext context) {
    Scaffold buildUnAuthScreen() {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(
                  height: 100.0,
                ),
                NavigatorButtonWhite(
                  buttonText: "GET STARTED",
                  navigateTo:
                      "signIn", //TODO: doesn't go back to prev screen again
                ),
              ],
            ),
          ),
        ),
      );
    }

    return buildUnAuthScreen();
  }
}
