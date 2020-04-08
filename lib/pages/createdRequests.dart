import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/PendingRequestCard.dart';
import 'package:erims/components/sizeConfig.dart';
import 'package:erims/models/event.dart';
import 'package:erims/components/header.dart';
import 'package:erims/components/progress.dart';
import 'package:erims/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';

class CreatedRequests extends StatefulWidget {
  var loggedInUser;
  User docUser;

  CreatedRequests(this.loggedInUser, this.docUser) {
    print(this.loggedInUser.runtimeType);
  }

  @override
  _CreatedRequestsState createState() => _CreatedRequestsState();
}

class _CreatedRequestsState extends State<CreatedRequests> {
  SlidingCardController controller;
  final _auth = FirebaseAuth.instance;
  //static FirebaseUser loggedInUser;
  //DocumentSnapshot docUser;
  bool load = false;
  @override
  void initState() {
    super.initState();
    controller = SlidingCardController();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        widget.loggedInUser = user;
        final DocumentSnapshot tempdoc = await Firestore.instance
            .collection('users')
            .document(widget.loggedInUser.uid)
            .get();
        if (tempdoc != null) {
          setState(() {
            final docUser = tempdoc;
            //userRole = docUser['designation'];
            widget.docUser=User.fromFirebaseDocument(docUser);
            load = true;
          });
          print(widget.docUser.designation + " is Online!");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: header(context, true),
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('events')
              .where('createdByID', isEqualTo: widget.loggedInUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return linearProgress(context);
            }
            final List<Widget> children = snapshot.data.documents
                .map(
                  (doc) => Event.fromFirebaseDocument(doc)
                      .toCreatedNotificationItem(context, controller,
                          doc.documentID, widget.loggedInUser, widget.docUser),
                )
                .toList();
            return Container(
              alignment: Alignment.centerLeft,
              child: ListView(
                children: children,
              ),
            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
