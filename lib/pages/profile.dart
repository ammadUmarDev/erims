import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/h2.dart';
import 'package:erims/components/profilePainter.dart';
import 'package:erims/components/progress.dart';
import 'package:erims/components/shadowBox.dart';
import 'package:erims/models/user.dart';
import 'package:erims/pages/createdRequests.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/bodyText.dart';
import '../components/h1.dart';
import 'pendingRequests.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  static FirebaseUser loggedInUser;
  User userObj;
  //String userRole = "Student";
  bool load = false;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    loggedInUser = null;
    getCurrentUser();
    super.initState();
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
      final double imageHeight = 340;
      final double circleAvatarRadius = 45;

      Image loadedImage = Image(
        height: imageHeight,
        image: AssetImage('assets/images/profileImage.jpg'),
        fit: BoxFit.cover,
      );

      String avatarImage = 'assets/images/studentDefaultAvatar.png';
      if (userObj.designation == 'Director') {
        avatarImage = 'assets/images/directorDefaultAvatar.png';
      } else if (userObj.designation == 'Society') {
        avatarImage = 'assets/images/societyDefaultAvatar.png';
      } else if (userObj.designation == 'Mentor') {
        avatarImage = 'assets/images/mentorDefaultAvatar.png';
      }

      void _showSnackBar(BuildContext context, String message) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1000),
        ));
      }

      // ignore: non_constant_identifier_names
      Widget LoadorNot() {
        if (load == false)
          return linearProgress(context);
        else
          return Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RotationTransition(
                    turns: new AlwaysStoppedAnimation(0 / 360),
                    child: loadedImage,
                  ),
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
                              Row(
                                children: <Widget>[
                                  H1(
                                    textBody: userObj.fullName, //'name',
                                  ),
                                  /*Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),*/
                                  /*IconButton(
                                    icon: Icon(
                                      Icons.power_settings_new,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      print('User Logout Successful');
                                      loggedInUser.email;
                                      _auth.signOut();
                                      Navigator.pushNamed(context, "signIn");
                                    },
                                  ),*/
                                ],
                              ),
                              BodyText(
                                textBody: userObj.designation,
                              ),
                              (userObj.department !=
                                      null) //TODO: remove this condition later when ALL data has dept in it
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
        /*appBar: AppBar(
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
        ),*/
        body: LoadorNot(),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.topRight,
            ringColor: Colors.grey[900].withOpacity(0.2),
            ringDiameter: 300.0,
            ringWidth: 60.0,
            fabSize: 50.0,
            fabElevation: 8.0,
            fabColor: Colors.white,
            fabOpenIcon:
                Icon(Icons.menu, color: Theme.of(context).primaryColor),
            fabCloseIcon:
                Icon(Icons.close, color: Theme.of(context).primaryColor),
            fabMargin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Icon(Icons.mode_edit, color: Colors.white),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "about");
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Icon(Icons.info, color: Colors.white),
              ),
              RawMaterialButton(
                onPressed: () {
                  _showSnackBar(context, "You have logged out.");
                  loggedInUser.email;
                  _auth.signOut();
                  Navigator.pushNamed(context, "signIn");
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Icon(Icons.power_settings_new, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          linearProgress(context),
        ],
      ));
    }
  }

  Widget profileButtons(double imageHeight, User userObj) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
      height: MediaQuery.of(context).size.height - imageHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ShadowBox(
            icon: Icon(Icons.calendar_today),
            heading: "Created Events Requests",
            text: "View status or edit created event requests.",
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
                  userObj.designation == "Director")
              ? (ShadowBox(
                  icon: Icon(Icons.calendar_today),
                  heading: "Pending Event Requests",
                  text: "Review and approve or reject event requests.",
                  onTapFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PendingRequests(loggedInUser, userObj),
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
