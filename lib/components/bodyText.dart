import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyTextStyle extends TextStyle {
  final fontFamily = "Cantarell";
  final fontSize = 13.0;
  final Color color;
  BodyTextStyle({this.color = const Color(0xFF35495e)});
}

class BodyText extends StatelessWidget {
  BodyText({
    this.textBody,
    this.color = const Color(0xFF35495e),
    this.align,
  });
  final String textBody;
  final Color color;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: BodyTextStyle(
        color: color,
      ),
      textAlign: align,
    );
  }
}
