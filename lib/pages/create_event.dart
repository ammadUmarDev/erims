import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/attachmentFieldErims.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/header.dart';
import 'package:erims/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/event.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../components/interTextFieldSpacing.dart';
import '../components/dateTimeFieldErims.dart';
import '../components/textFieldErims.dart';
import '../components/h1.dart';
import '../components/h2.dart';
import 'package:erims/components/dropDownFieldErims.dart';

import '../pages/confirm_create_event.dart';

class CreateEvent extends StatefulWidget {
  static final String id = 'Screens.CreateEvent';

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  Event createdEvent;
  String _categoryFT;
  bool dropDownFT;
  String forwardToUser;
  DocumentSnapshot docUser;
  String userRole = "Student";
  String forwardToRole;
  User userObj;

  @override
  void initState() {
    super.initState();
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
            userRole = docUser['designation'];
            if (userRole == "Student" || userRole == "Society") {
              forwardToRole = "Mentor";
            }
            if (userRole == "Mentor") {
              forwardToRole = "Head of Department";
            }
            if (userRole == "Head of Department") {
              forwardToRole = "Director";
            }
            if (userRole == "Director") {
              forwardToRole = "Director";
            }
            userObj = User.fromFirebaseDocument(docUser);
            //load = true;
          });
          print(userObj.designation + " is Online!");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static List<String> refreshmentType = <String>[
    'Lite Tea',
    'Hi Tea',
    'Lunch',
  ];

  String ecreatorUser;
  TextFieldErims eNameTextField = TextFieldErims(
    textFieldText: 'Event Name',
    textFieldIcon: Icon(Icons.event),
  );
  TextFieldErims eDescriptionTextField = TextFieldErims(
    textFieldText: 'Event Description',
    textFieldIcon: Icon(Icons.event),
    keyboardType: TextInputType.multiline,
  );
  TextFieldErims gNameTextField = TextFieldErims(
    textFieldText: 'Name', //TODO: allow addition of guests as per user's choice
    textFieldIcon: Icon(Icons.person),
  );
  TextFieldErims gCompanyTextField = TextFieldErims(
    textFieldText: 'Company',
  );
  DateTimeFieldErims eStartDateTimeField = DateTimeFieldErims(
    labelText: 'Starting Date & Time',
  );
  DateTimeFieldErims eEndDateTimeField = DateTimeFieldErims(
    labelText: 'Ending Date & Time',
  );
  TextFieldErims eAttendeesNoTextField = TextFieldErims(
    textFieldText:
        'Expected No Of Attendees', //TODO: add icon which indicates integer input
    keyboardType: TextInputType.number,
  );
  TextFieldErims eVenueTextField = TextFieldErims(
    textFieldText: 'Venue', //TODO: add dropdown for available venues
  );
  TextFieldErims oContactNoTextField = TextFieldErims(
    textFieldText: 'Active Contact No', //TODO: add verification of phone no
    keyboardType: TextInputType.phone,
    textFieldIcon: Icon(Icons.phone),
  );
  DropDownFieldErims selectRefreshmentType = DropDownFieldErims(
    refreshmentType,
    defaultHeading: 'Refreshment Type',
  );
  Text selectedRefreshmentType;
  TextFieldErims rPersonNoTextField = TextFieldErims(
    textFieldText: 'No Of Persons',
    keyboardType: TextInputType.number,
  );
  DateTimeFieldErims rServeDateTimeField = DateTimeFieldErims(
    labelText: 'Serving Date & Time',
  );
  TextFieldErims rMenuItemsTextField = TextFieldErims(
    textFieldText: 'Menu Items', //TODO: MAYBE: add options checklist
  );
  List<String> selectedServices;
  AttachmentFieldErims eventAttachment = AttachmentFieldErims(
    title: 'Event Attachments',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true, "Create New Event Request"),
      backgroundColor: Color(0xff274960),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                H1(
                  textBody: 'Create Event',
                ),
                InterTextFieldSpacing(),
                eNameTextField,
                InterTextFieldSpacing(),
                eDescriptionTextField,
                InterTextFieldSpacing(),
                H2(
                  textBody: 'Guest Speaker',
                ),
                InterTextFieldSpacing(),
                gNameTextField,
                InterTextFieldSpacing(),
                gCompanyTextField,
                InterTextFieldSpacing(),
                H2(
                  textBody: 'Event Details',
                ),
                InterTextFieldSpacing(),
                //event details heading
                eStartDateTimeField,
                InterTextFieldSpacing(),
                eEndDateTimeField,
                InterTextFieldSpacing(),
                eAttendeesNoTextField,
                InterTextFieldSpacing(),
                eVenueTextField,
                InterTextFieldSpacing(),
                H2(
                  textBody: 'Organizer\'s Details',
                ),
                //InterTextFieldSpacing(),
                //oDepartmentTextField,
                //InterTextFieldSpacing(),
                //oNameTextField,
                InterTextFieldSpacing(),
                oContactNoTextField,
                InterTextFieldSpacing(),
                H2(
                  textBody: 'Serving of Refreshments',
                ),
                InterTextFieldSpacing(),
                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[500],
                      )),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<Text>(
                            isExpanded: true,
                            isDense: false,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                            ),
                            hint: Text("Refreshment Type"),
                            value: selectedRefreshmentType,
                            onChanged: (Text value) {
                              setState(() {
                                selectedRefreshmentType = value;
                              });
                            },
                            items:
                                refreshmentType.map((String refreshmentType) {
                              return DropdownMenuItem<Text>(
                                value: Text(refreshmentType),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      refreshmentType,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InterTextFieldSpacing(),
                rPersonNoTextField,
                InterTextFieldSpacing(),
                rServeDateTimeField,
                InterTextFieldSpacing(),
                rMenuItemsTextField,
                InterTextFieldSpacing(),
                H2(
                  textBody: 'Services Required',
                ),
                InterTextFieldSpacing(),

                CheckboxGroup(
                  //TODO: customize display according to brand standards
                  labels: <String>[
                    'Manager Admin',
                    'AM Media',
                    'Manager IT',
                    'Security',
                    'Manager SA',
                    'Maintenance Dept',
                    'Furniture',
                    'Sound System',
                    'Multi-media',
                    'Transport',
                  ],
                  onSelected: (List<String> checked) {
                    selectedServices = checked;
                  },
                ),
                InterTextFieldSpacing(),
                eventAttachment,
                InterTextFieldSpacing(),

                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('users')
                        .where('designation', isEqualTo: forwardToRole)
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
                              padding:
                                  EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
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
                                                  BorderRadius.circular(5.0)),
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 2.0, 10.0, 0.0),
                                          child: Text(document.data['email']),
                                        ));
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                InterTextFieldSpacing(),
                InterTextFieldSpacing(),
                //create event button
                ButtonErims(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.Idle) {
                      startLoading();
                      print('User Creating Event:');
                      final FirebaseUser user = loggedInUser;
                      final userId = user.uid;
                      try {
                        Firestore.instance
                            .collection('users')
                            .where('email', isEqualTo: _categoryFT)
                            .snapshots()
                            .listen((QuerySnapshot querySnapshot) {
                          querySnapshot.documents.forEach((document) =>
                              forwardToUser = document.documentID);
                        });
                        createdEvent = new Event(
                          eNameTextField.getReturnValue(),
                          eDescriptionTextField.getReturnValue(),
                          gNameTextField.getReturnValue(),
                          gCompanyTextField.getReturnValue(),
                          eStartDateTimeField.getReturnValue(),
                          eEndDateTimeField.getReturnValue(),
                          int.parse(eAttendeesNoTextField.getReturnValue()),
                          eVenueTextField.getReturnValue(),
                          DateTime.now(),
                          userObj.department,
                          userObj.fullName,
                          oContactNoTextField.getReturnValue(),
                          rMenuItemsTextField.getReturnValue(),
                          int.parse(rPersonNoTextField.getReturnValue()),
                          rServeDateTimeField.getReturnValue(),
                          selectRefreshmentType.getSelectedValue(),
                          selectedServices,
                          userId,
                          false,
                          forwardToUser,
                          false,
                        );

                        if (createdEvent != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmCreateEvent(
                                      createdEvent: createdEvent)));
                        }
                      } catch (e) {
                        print(e);
                      }
                      stopLoading();
                    } else {
                      stopLoading();
                    }
                  },
                  labelText: 'CREATE EVENT',
                ),
                InterTextFieldSpacing(),
                InterTextFieldSpacing(),
                InterTextFieldSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
