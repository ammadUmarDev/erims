import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavigatorButtonBlue extends StatelessWidget {
  NavigatorButtonBlue({
    this.buttonText,
    this.navigateTo,
  });
  final String buttonText;
  final String navigateTo;

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          await Navigator.pushNamed(context, navigateTo);
          stopLoading();
        } else {
          stopLoading();
        }
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          fontFamily: "Cantarell",
        ),
      ),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: Colors.white,
          // size: loaderWidth ,
        ),
      ),
      borderRadius: 22.0,
      //Color(0xFFee8572)
      color: Colors.white,
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 3.0,
      ),
    );
  }
}
