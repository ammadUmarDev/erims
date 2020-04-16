import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/bodyText.dart';
import 'package:erims/models/user.dart';
import 'package:erims/pages/view_event_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'buttonErims.dart';
import 'h2.dart';
import 'sizeConfig.dart';

class RequestFrontCard extends StatefulWidget {
  final String eventDesc;
  final String eventName;
  final Function onInfoTapped;
  final Function onRedCloseButtonTapped;
  final Function onAccep;
  final Function onDecline;
  final String eventStartDateTime;
  final String eventEndDateTime;
  final String imgLink;
  final String eventID;
  final FirebaseUser currentUser;
  final User user;
  final bool pending;

  const RequestFrontCard(
      {Key key,
      @required this.imgLink,
      @required this.onAccep,
      @required this.onDecline,
      @required this.eventDesc,
      @required this.onInfoTapped,
      @required this.eventName,
      @required this.eventStartDateTime,
      @required this.eventEndDateTime,
      @required this.onRedCloseButtonTapped,
      this.eventID,
      this.currentUser,
      this.user,
      this.pending})
      : super(key: key);
  @override
  _RequestFrontCardState createState() => _RequestFrontCardState();
}

class _RequestFrontCardState extends State<RequestFrontCard> {
  bool isinfoPressed = false;
  String _categoryFT;
  bool dropDownFT;
  String forwardToUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isinfoPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: H2(
                            textBody: widget.eventName,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: SizeConfig.safeBlockHorizontal * 4,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BodyText(
                          textBody: widget.eventStartDateTime +
                              '  to  ' +
                              widget.eventEndDateTime,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 100,
                      //color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 10,
                            child: BodyText(
                              textBody: widget.eventDesc,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      isinfoPressed = false;
                                      widget.onRedCloseButtonTapped();
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewEventInfo(
                                              eventDocumentID: widget.eventID,
                                              loggedInUser: widget.currentUser,
                                            ),
                                          ));
                                    },
                                    child: isinfoPressed
                                        ? Transform.rotate(
                                            angle: 0.7777,
                                            child: Icon(
                                              Icons.info,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  7,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        : Icon(
                                            Icons.info,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                    7,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: returnStreamBuilderWithRole(),
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    disabledElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    hoverElevation: 0,
                                    elevation: 0,
                                    textColor: Colors.black26,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.clear,
                                      size: SizeConfig.safeBlockHorizontal * 7,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: widget.onDecline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget returnStreamBuilderWithRole() {
    if (widget.pending == true) {
      if (widget.user.designation == "Mentor" &&
          widget.user.designation != null) {
        //user is mentor -> hods:
        return RaisedButton(
            disabledElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            elevation: 0,
            color: Theme.of(context).accentColor.withOpacity(0.02),
            child: Icon(
              Icons.check,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Alert(
                    context: context,
                    title: "You Have Approved!",
                    style: AlertStyle(
                      titleStyle: TextStyle(
                        fontFamily: "Cantarell",
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    content: Column(
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('users')
                                .where('designation',
                                    isEqualTo: 'Head of Department')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return const Center(
                                  child: const CupertinoActivityIndicator(),
                                );
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          12.0, 10.0, 10.0, 10.0),
                                      child: H2(
                                        textBody: "Forward Request To:",
                                        align: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      height: 55.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      child: Center(
                                        child: DropdownButton(
                                          value: _categoryFT,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _categoryFT = newValue;
                                              dropDownFT = false;
                                              print(_categoryFT);
                                            });
                                          },
                                          items: snapshot.data.documents
                                              .map((DocumentSnapshot document) {
                                            return DropdownMenuItem<String>(
                                                value: document.data['email'],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 2.0, 10.0, 0.0),
                                                  child: Text(
                                                      document.data['email']),
                                                ));
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Forwarding Event:');
                              Firestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: _categoryFT)
                                  .snapshots()
                                  .listen((QuerySnapshot querySnapshot) {
                                querySnapshot.documents.forEach((document) =>
                                    forwardToUser = document.documentID);
                              });

                              final doc = await Firestore.instance
                                  .collection('events')
                                  .document(widget.eventID)
                                  .get();
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "forwardedTo": forwardToUser,
                                });
                              }
                              stopLoading();
                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'PROCEED',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                      ),
                    ]).show() //widget.onAccep
            );
      }
      if (widget.user.designation == "Head of Department" &&
          widget.user.designation != null) {
        //user is hod -> directors:
        return RaisedButton(
            disabledElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            elevation: 0,
            color: Theme.of(context).accentColor.withOpacity(0.02),
            child: Icon(
              Icons.check,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Alert(
                    context: context,
                    title: "You Have Approved!",
                    style: AlertStyle(
                      titleStyle: TextStyle(
                        fontFamily: "Cantarell",
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    content: Column(
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('users')
                                .where('designation', isEqualTo: 'Director')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return const Center(
                                  child: const CupertinoActivityIndicator(),
                                );
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          12.0, 10.0, 10.0, 10.0),
                                      child: H2(
                                        textBody: "Forward Request To:",
                                        align: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      height: 55.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      child: Center(
                                        child: DropdownButton(
                                          value: _categoryFT,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _categoryFT = newValue;
                                              dropDownFT = false;
                                              print(_categoryFT);
                                            });
                                          },
                                          items: snapshot.data.documents
                                              .map((DocumentSnapshot document) {
                                            return DropdownMenuItem<String>(
                                                value: document.data['email'],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 2.0, 10.0, 0.0),
                                                  child: Text(
                                                      document.data['email']),
                                                ));
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Forwarding Event:');
                              Firestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: _categoryFT)
                                  .snapshots()
                                  .listen((QuerySnapshot querySnapshot) {
                                querySnapshot.documents.forEach((document) =>
                                    forwardToUser = document.documentID);
                              });

                              final doc = await Firestore.instance
                                  .collection('events')
                                  .document(widget.eventID)
                                  .get();
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "forwardedTo": forwardToUser,
                                });
                              }
                              stopLoading();
                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'PROCEED',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                      ),
                    ]).show() //widget.onAccep
            );
      }
      if (widget.user.designation == "Director" &&
          widget.user.designation != null) {
        //user is director -> ultimate approval
        return RaisedButton(
            disabledElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            elevation: 0,
            color: Theme.of(context).accentColor.withOpacity(0.02),
            child: Icon(
              Icons.check,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Alert(
                    context: context,
                    title: "You Have Approved!",
                    style: AlertStyle(
                      titleStyle: TextStyle(
                        fontFamily: "Cantarell",
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Approving Event:');
                              final doc = await Firestore.instance
                                  .collection('events')
                                  .document(widget.eventID)
                                  .get();
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "isApproved": true,
                                });
                              }
                              stopLoading();
                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'PROCEED',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                      ),
                    ]).show() //widget.onAccep
            );
      }
    }
    return SizedBox(height: 0);
    //return Text("maro mujhe maro");
  }
}
