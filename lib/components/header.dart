import 'package:flutter/material.dart';

import 'h1.dart';

// ignore: missing_return
AppBar header(BuildContext context, bool leading, String pageName) {
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: Container(
            height: 45.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: H1(
              textBody: pageName,
              color: Theme.of(context).primaryColor,
            ),
            decoration: BoxDecoration(color: Colors.white),
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: Container(
            height: 45.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: H1(
              textBody: pageName,
              color: Theme.of(context).primaryColor,
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
}
