import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class ConfirmCreateEvent extends StatefulWidget {
  static final String id = 'Screens.ConfirmCreateEvent';

  ConfirmCreateEvent({this.createdEvent});

  final Event createdEvent;

  @override
  _ConfirmCreateEventState createState() => _ConfirmCreateEventState();
}

class _ConfirmCreateEventState extends State<ConfirmCreateEvent> {
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Event Request Summary',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Name: ' + widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            //Text(widget.createdEvent._eName),
            Text(
              'Description: ' + widget.createdEvent.eDescription,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            Text(
              'Guest Speaker',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Name: ' + widget.createdEvent.gName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Company: ' + widget.createdEvent.gCompany,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Event Details',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            /*
            Text(
              'Starting Date: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Starting Time: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Ending Date: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Ending Time: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            */
            Text(
              'Venue: ' + widget.createdEvent.eVenue,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Expected No of Attendees: ' +
                  widget.createdEvent.eAttendeesNo.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Organizer\'s Details',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Department: ' + widget.createdEvent.oDepartment,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Name: ' + widget.createdEvent.oName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Contact No: ' + widget.createdEvent.oContactNo,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Serving of Refreshments',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Refreshment Type: ' +
                  widget.createdEvent.selectedRefreshmentType,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'No of Persons: ' + widget.createdEvent.rPersonNo.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            /*
            Text(
              'Serving Date: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              'Serving Time: '+widget.createdEvent.eName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
             */
            Text(
              'Menu Items: ' + widget.createdEvent.rMenuItems,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Services Required',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            Text(
              widget.createdEvent.selectedServices.toString(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //confirm button
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonErims(
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          try {
                            final newEvent = await widget.createdEvent
                                .addToFirebase(_firestore);
                            if (newEvent != null) {
                              Navigator.pushNamed(context, "dashBoard");
                            }
                          } catch (e) {
                            print(e);
                          }
                          stopLoading();
                        } else {
                          stopLoading();
                        }
                      },
                      labelText: 'CONFIRM',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonErims(
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          Navigator.pop(context);
                          stopLoading();
                        } else {
                          stopLoading();
                        }
                      },
                      labelText: 'CANCEL',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
