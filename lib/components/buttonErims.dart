import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonErims extends StatefulWidget {

  ButtonErims({@required this.onTap,@required this.labelText});

  dynamic Function(Function, Function, ButtonState) onTap;
  String labelText;

  @override
  _ButtonErimsState createState() => _ButtonErimsState();
}

class _ButtonErimsState extends State<ButtonErims> {
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: widget.onTap,
      child: Text(
        widget.labelText,
        style: TextStyle(
          color: Color(0xFF35495e),
          fontSize: 15,
          fontWeight: FontWeight.w800,
          fontFamily: "Cantarell",
        ),
      ),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: Color(0xFF35495e),
        ),
      ),
      borderRadius: 22.0,
      color: Colors.white,
      borderSide: BorderSide(
        color: Color(0xFFee8572),
        width: 4.0,
      ),
    );
  }
}
