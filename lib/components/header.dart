import 'package:flutter/material.dart';

AppBar header(BuildContext context, bool leading) {
  if (leading == false)
    return AppBar(
      title: Text(
        "E.R.I.M.S",
        style: TextStyle(
          fontFamily: "Cantarell",
          fontSize: 23.0,
          color: Colors.white,
        ),
      ),
      leading: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/icons/erims.png')),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
      ),
    );
  if (leading == true)
    return AppBar(
      title: Text(
        "E.R.I.M.S",
        style: TextStyle(
          fontFamily: "Cantarell",
          fontSize: 23.0,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
      ),
    );
}
