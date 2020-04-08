import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/h2.dart';
import 'package:erims/components/profilePainter.dart';
import 'package:erims/components/progress.dart';
import 'package:erims/components/shadowBox.dart';
import 'package:erims/models/user.dart';
import 'package:erims/pages/createdRequests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/bodyText.dart';
import '../components/h1.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  static FirebaseUser loggedInUser;
  User userObj;
  //String userRole = "Student";
  bool load = false;

  @override
  void initState() {
    super.initState();
    loggedInUser = null;
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        final DocumentSnapshot tempdoc = await Firestore.instance
            .collection('users')
            .document(loggedInUser.uid)
            .get();
        if (tempdoc != null) {
          setState(() {
            final docUser = tempdoc;
            //userRole = docUser['designation'];
            userObj = User.fromFirebaseDocument(docUser);
            load = true;
          });
          print(userObj.designation + " is Online!");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser != null) {
      final double imageHeight = 250;
      final double circleAvatarRadius = 45;

      Image loadedImage = Image(
        height: imageHeight,
        image: AssetImage('assets/images/profileImage.jpg'),
        fit: BoxFit.fill,
      );

      String avatarImage = 'assets/images/studentDefaultAvatar.png';
      if (userObj.designation == 'Director') {
        avatarImage = 'assets/images/directorDefaultAvatar.png';
      } else if (userObj.designation == 'Society') {
        avatarImage = 'assets/images/societyDefaultAvatar.png';
      } else if (userObj.designation == 'Mentor') {
        avatarImage = 'assets/images/mentorDefaultAvatar.png';
      }

      Widget LoadorNot() {
        if (load == false)
          return linearProgress(context);
        else
          return Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  loadedImage,
                  Container(),
                ],
              ),
              Positioned(
                top: 100.0,
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  height: imageHeight - 100,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: CustomPaint(
                    painter: ProfilePainter(),
                  ),
                ),
              ),
              Positioned(
                left: 10.0,
                top: imageHeight - 100,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          radius: circleAvatarRadius,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(avatarImage),
                        ),
                        Container(
                          height: circleAvatarRadius * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              H1(
                                textBody: userObj.fullName, //'name',
                              ),
                              BodyText(
                                textBody: userObj.designation,
                              ),
                              (userObj.department != null) //TODO: remove this condition later when ALL data has dept in it
                                  ? (FittedBox(
                                      child: Text(
                                        userObj.department,
                                        style: BodyTextStyle(),
                                      ),
                                    ))
                                  : (Container()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: imageHeight,
                child: Column(
                  children: <Widget>[
                    profileButtons(imageHeight, userObj),
                    H2(textBody: "Notifications"),
                  ],
                ),
              ),
            ],
          );
      }

      return Scaffold(
        appBar: AppBar(
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
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(10.0),
              icon: Image.asset('assets/icons/logout.png'),
              onPressed: () {
                print('User Logout Successful');
                loggedInUser.email;
                _auth.signOut();
                Navigator.pushNamed(context, "signIn");
              },
            ),
          ],
        ),
        body: LoadorNot(),
      );
    } else {
      return Center(
        child: H1(
          textBody: "Loading", //TODO: add the loading bar here
        ),
      );
    }
  }

  Widget profileButtons(double imageHeight, User userObj) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
      height: MediaQuery.of(context).size.height - imageHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ShadowBox(
            icon: Icon(Icons.calendar_today),
            heading: "Created Events Requests",
            text: "Approve or reject event requests after reviewing.",
            onTapFunction: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreatedRequests(loggedInUser, userObj),
                  ));
            }, //
          ),
          (userObj.designation == "Mentor" ||
                  userObj.designation == "Head of Department" ||
                  userObj.designation == "Head of Department")
              ? (ShadowBox(
                  icon: Icon(Icons.calendar_today),
                  heading: "Created Events Requests",
                  text: "Approve or reject event requests after reviewing.",
                  onTapFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreatedRequests(loggedInUser, userObj),
                        ));
                  }, //
                ))
              : (Container()),
          SizedBox(
            height: 4,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
