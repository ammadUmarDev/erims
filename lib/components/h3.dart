import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class H3 extends StatelessWidget {
  H3({
    this.textBody,
    this.color = const Color(0xFF35495e),
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: TextStyle(
        fontFamily: "Cantarell",
        fontSize: 14.0,
        color: color,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
