import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';
import 'PendingRequestFrontCard.dart';
import 'sizeConfig.dart';

///This is the main Appointment card
///it regroups the AppointmentFrontCard
///and AppointmentBacktCard together
///using my future dart package ''SlidingCard''
class PendingRequestCard extends StatefulWidget {
  const PendingRequestCard({
    Key key,
    this.eventId,
    this.slidingCardController,
    @required this.onCardTapped,
    this.eventDesc,
    this.eventName,
    this.eventStartDateTime,
    this.eventEndDateTime,
    this.currentUser,
    this.userDocument,
    this.pending,
  }) : super(key: key);

  final SlidingCardController slidingCardController;
  final Function onCardTapped;
  final String eventDesc;
  final String eventName;
  final String eventStartDateTime;
  final String eventEndDateTime;
  final String eventId;
  final FirebaseUser currentUser;
  final DocumentSnapshot userDocument;
  final bool pending;

  @override
  _PendingRequestCardState createState() => _PendingRequestCardState();
}

class _PendingRequestCardState extends State<PendingRequestCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Card tapped');
      },
      child: SlidingCard(
        slimeCardElevation: 0.5,
        // slidingAnimationReverseCurve: Curves.bounceInOut,
        cardsGap: SizeConfig.safeBlockVertical,
        controller: widget.slidingCardController,
        slidingCardWidth: SizeConfig.horizontalBloc * 95,
        visibleCardHeight: SizeConfig.safeBlockVertical * 26,
        hiddenCardHeight: SizeConfig.safeBlockVertical * 0,
        frontCardWidget: RequestFrontCard(
          pending: widget.pending,
          userDocument: widget.userDocument,
          currentUser: widget.currentUser,
          eventID: widget.eventId,
          eventDesc: widget.eventDesc,
          eventName: widget.eventName,
          eventStartDateTime: widget.eventStartDateTime,
          eventEndDateTime: widget.eventEndDateTime,
          onInfoTapped: () {
            print('info pressed');
          },
          onDecline: () async {
            print('Declined');
            final doc = await Firestore.instance
                .collection('events')
                .document(widget.eventId)
                .get();
            if (doc.exists) {
              doc.reference.updateData({"isRejected": true});
            }
          },
          onAccep: () async {
            print('Accepted');
          },
          onRedCloseButtonTapped: () {},
        ),
      ),
    );
  }
}
