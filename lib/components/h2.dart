import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  H2({
    this.textBody,
    this.color = const Color(0xFF35495e),
    this.align = TextAlign.left,
  });
  final String textBody;
  final Color color;
  final align;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: TextStyle(
        fontFamily: "Cantarell",
        fontSize: 16.0,
        color: color,
        fontWeight: FontWeight.w900,
      ),
      textAlign: align,
    );
  }
}
