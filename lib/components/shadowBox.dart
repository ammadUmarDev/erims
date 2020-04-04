import 'package:erims/components/bodyText.dart';
import 'package:erims/components/h1.dart';
import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  final Icon icon;
  final String heading;
  final String text;
  final Function onTapFunction;

  ShadowBox({this.icon, this.heading, this.text, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).accentColor.withOpacity(0.2),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 0.1, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Center(
                  child: icon,
                  widthFactor: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    H1(textBody: heading),
                    SizedBox(
                      height: 5,
                    ),
                    BodyText(
                      textBody: text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: onTapFunction,
      ),
    );
  }
}
