import 'package:erims/pages/create_event_intro.dart';
import 'package:erims/pages/post_feed.dart';
import 'package:erims/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'event_calender.dart';

class DashBoard extends StatefulWidget {
  static final String id = 'dashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String userName;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    pageController = PageController();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
          userName = loggedInUser.email;
          print(loggedInUser.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: buildHomeScreen(),
    );
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          PostFeed(),
          EventCalender(),
          CreateEventIntro(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Color(0xFFee8572),
        inactiveColor: Color(0xFF35495e),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.whatshot,
            size: 28,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.calendar_today,
            size: 25,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.pages,
            size: 30,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.person,
            size: 30,
          )),
        ],
      ),
    );
  }
}
