import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/PendingRequestCard.dart';
import 'package:erims/components/bodyText.dart';
import 'package:erims/components/h2.dart';
import 'package:erims/components/h3.dart';
import 'package:erims/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_card/sliding_card.dart';

class Event {
  String rMenuItems,
      eVenue,
      eName,
      eDescription,
      gName,
      gCompany,
      oDepartment,
      oName,
      oContactNo,
      selectedRefreshmentType,
      createdByID,
      forwardedTo;
  DateTime rServeDateTime, oFormSubDateTime, eStartDateTime, eEndDateTime;
  int rPersonNo, eAttendeesNo;
  List<String> selectedServices;
  bool isApproved, isRejected;

  Event(
    this.eName,
    this.eDescription,
    this.gName,
    this.gCompany,
    this.eStartDateTime,
    this.eEndDateTime,
    this.eAttendeesNo,
    this.eVenue,
    this.oFormSubDateTime,
    this.oDepartment,
    this.oName,
    this.oContactNo,
    this.selectedRefreshmentType,
    this.rPersonNo,
    this.rServeDateTime,
    this.rMenuItems,
    this.selectedServices,
    this.createdByID,
    this.isApproved,
    this.forwardedTo,
    this.isRejected,
  );

  Event.fromFirebaseDocument(DocumentSnapshot firebaseDocument) {
    eName = firebaseDocument.data['eName'];
    eAttendeesNo = firebaseDocument.data['eAttendeesNo'];
    eDescription = firebaseDocument.data['eDescription'];
    eEndDateTime = firebaseDocument.data['eEndDateTime'].toDate();
    eStartDateTime = firebaseDocument.data['eStartDateTime'].toDate();
    eVenue = firebaseDocument.data['eVenue'];
    gCompany = firebaseDocument.data['gCompany'];
    gName = firebaseDocument.data['gName'];
    oContactNo = firebaseDocument.data['oContactNo'];
    oDepartment = firebaseDocument.data['oDepartment'];
    oFormSubDateTime = firebaseDocument.data['oFormSubDate'].toDate();
    oName = firebaseDocument.data['oName'];
    rMenuItems = firebaseDocument.data['rMenuItems'];
    rPersonNo = firebaseDocument.data['rPersonNo'];
    rServeDateTime = firebaseDocument.data['rServeDateTime'].toDate();
    selectedRefreshmentType = firebaseDocument.data['selectedRefreshmentType'];
    selectedServices = [];
    for (var d in firebaseDocument.data['selectedServices']) {
      selectedServices.add(d.toString());
    }
    isApproved = firebaseDocument.data['isApproved'];
    forwardedTo = firebaseDocument.data['forwardedTo'];
    isRejected = firebaseDocument.data['isRejected'];
  }

  Future<DocumentReference> addToFirebase(Firestore firestore) async {
    return await firestore.collection('events').add({
      'eName': eName,
      'eAttendeesNo': eAttendeesNo,
      'eDescription': eDescription,
      'eEndDateTime': eEndDateTime,
      'eStartDateTime': eStartDateTime,
      'eVenue': eVenue,
      'gCompany': gCompany,
      'gName': gName,
      'oContactNo': oContactNo,
      'oDepartment': oDepartment,
      'oFormSubDate': oFormSubDateTime,
      'oName': oName,
      'rMenuItems': rMenuItems,
      'rPersonNo': rPersonNo,
      'rServeDateTime': rServeDateTime,
      'selectedRefreshmentType': selectedRefreshmentType,
      'selectedServices': selectedServices,
      'createdByID': createdByID,
      "isApproved": isApproved,
      "forwardedTo": forwardedTo,
      "isRejected": isRejected,
    });
  }

  Widget toPostFeedItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.grey,
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                H2(textBody: eName),
                BodyText(
                  textBody: eDescription,
                  align: TextAlign.justify,
                ),
                SizedBox(height: 10),
                H2(textBody: "Guest Speaker: " + gName),
                H2(textBody: "Organization: " + gCompany),
                SizedBox(height: 10),
                H3(textBody: "Venue: " + eVenue),
                Row(
                  children: <Widget>[
                    H3(
                      textBody: "Start Time: ",
                    ),
                    BodyText(
                      textBody: new DateFormat('EEE, MMM d, ' 'yyyy, hh:mm aaa')
                          .format(eStartDateTime),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    H3(
                      textBody: "End Time: ",
                    ),
                    BodyText(
                      textBody: new DateFormat('EEE, MMM d, ' 'yyyy, hh:mm aaa')
                          .format(eEndDateTime),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget toPendingNotificationItem(
    BuildContext context,
    SlidingCardController controller,
    String documentID,
    FirebaseUser loggedInUser,
    User docUser,
  ) {
    return Center(
      child: PendingRequestCard(
        onCardTapped: () {
          print('Card tapped controller can be used here ');
          if (controller.isCardSeparated == true) {
            controller.collapseCard();
          } else {
            controller.expandCard();
          }
        },
        pending: true,
        currentUser: loggedInUser,
        user: docUser,
        slidingCardController: controller,
        eventId: documentID,
        eventName: eName,
        eventDesc: eDescription,
        eventStartDateTime:
            DateFormat('MMM d ' ', hh:mm aaa').format(eStartDateTime),
        eventEndDateTime:
            DateFormat('MMM d ' ', hh:mm aaa').format(eEndDateTime),
      ),
    );
  }

  Widget toCreatedNotificationItem(
    BuildContext context,
    SlidingCardController controller,
    String documentID,
    FirebaseUser loggedInUser,
    User docUser,
  ) {
    return Center(
      child: PendingRequestCard(
        onCardTapped: () {
          print('Card tapped controller can be used here ');
          if (controller.isCardSeparated == true) {
            controller.collapseCard();
          } else {
            controller.expandCard();
          }
        },
        pending: false,
        currentUser: loggedInUser,
        user: docUser,
        slidingCardController: controller,
        eventId: documentID,
        eventName: eName,
        eventDesc: eDescription,
        eventStartDateTime:
            DateFormat('MMM d ' ', hh:mm aaa').format(eStartDateTime),
        eventEndDateTime:
            DateFormat('MMM d ' ', hh:mm aaa').format(eEndDateTime),
      ),
    );
  }

/*Map<DateTime, List<Event>> toMapForCalendar() {
    final daysToGenerate = eEndDateTime.difference(eStartDateTime).inDays;
    Map<DateTime, List<Event>> m;
    List<Event> list = [];
    list.add(this);
    if (daysToGenerate == 0) {
//      m.putIfAbsent(eStartDateTime, list);
      //m.putIfAbsent(eStartDateTime, () => list);
      m = {
        eStartDateTime: [this],
      };
      return m;
    }
    final days = List.generate(
      daysToGenerate,
      (i) => DateTime(
        eStartDateTime.year,
        eStartDateTime.month,
        eStartDateTime.day + (i),
      ),
    );
    for (var day in days) {
      m[day] = list;
    }
    //print(m);
    return m;
  }*/
}
