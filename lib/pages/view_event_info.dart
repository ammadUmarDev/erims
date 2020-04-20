import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/bodyText.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/dateTimeFieldErims.dart';
import 'package:erims/components/dropDownFieldErims.dart';
import 'package:erims/components/h2.dart';
import 'package:erims/components/h3.dart';
import 'package:erims/components/interTextFieldSpacing.dart';
import 'package:erims/components/shadowBox.dart';
import 'package:erims/components/shadowBoxList.dart';
import 'package:erims/components/textFieldErims.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/header.dart';

class ViewEventInfo extends StatefulWidget {
  ViewEventInfo({@required this.eventDocumentID, this.loggedInUser});
  final String eventDocumentID;
  final FirebaseUser loggedInUser;
  final documentRef = Firestore.instance.collection("events");

  @override
  _ViewEventInfoState createState() => _ViewEventInfoState();
}

class _ViewEventInfoState extends State<ViewEventInfo> {
  DocumentSnapshot eventDoc;
  bool dropDownFT;

  static List<String> refreshmentType = <String>[
    'Lite Tea',
    'Hi Tea',
    'Lunch',
  ];

  TextFieldErims eNameTextField = TextFieldErims(
    textFieldText: 'New Event Name',
    textFieldIcon: Icon(Icons.event),
  );
  TextFieldErims eDescriptionTextField = TextFieldErims(
    textFieldText: 'New Event Description',
    textFieldIcon: Icon(Icons.event),
    keyboardType: TextInputType.multiline,
  );
  TextFieldErims gNameTextField = TextFieldErims(
    textFieldText:
        'New Name', //TODO: allow addition of guests as per user's choice
    textFieldIcon: Icon(Icons.person),
  );
  TextFieldErims gCompanyTextField = TextFieldErims(
    textFieldText: 'New Company',
  );
  DateTimeFieldErims eStartDateTimeField = DateTimeFieldErims(
    labelText: 'New Starting Date & Time',
  );
  DateTimeFieldErims eEndDateTimeField = DateTimeFieldErims(
    labelText: 'New Ending Date & Time',
  );
  TextFieldErims eAttendeesNoTextField = TextFieldErims(
    textFieldText:
        'New Participants', //TODO: add icon which indicates integer input
    keyboardType: TextInputType.number,
  );
  TextFieldErims eVenueTextField = TextFieldErims(
    textFieldText: 'New Venue', //TODO: add dropdown for available venues
  );
  TextFieldErims oContactNoTextField = TextFieldErims(
    textFieldText: 'New Active Contact No', //TODO: add verification of phone no
    keyboardType: TextInputType.phone,
    textFieldIcon: Icon(Icons.phone),
  );
  DropDownFieldErims selectRefreshmentType = DropDownFieldErims(
    refreshmentType,
    defaultHeading: 'New Refreshment Type',
  );
  Text selectedRefreshmentType;
  TextFieldErims rPersonNoTextField = TextFieldErims(
    textFieldText: 'New No Of Persons',
    keyboardType: TextInputType.number,
  );
  DateTimeFieldErims rServeDateTimeField = DateTimeFieldErims(
    labelText: 'New Serving Date & Time',
  );
  TextFieldErims rMenuItemsTextField = TextFieldErims(
    textFieldText: 'New Menu Items', //TODO: MAYBE: add options checklist
  );
  List<String> selectedServices;

  @override
  void initState() {
    getEventDoc();
    super.initState();
  }

  void getEventDoc() async {
    setState(() async {
      eventDoc =
          await widget.documentRef.document(widget.eventDocumentID).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, true, "Event Request Details"),
      body: eventInfoCard(context),
    );
  }

  Widget eventInfoCard(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false)
              ? (ShadowBox(
                  icon: Icon(Icons.info_outline),
                  heading: "Status",
                  text: "Pending",
                  onTapFunction: () {}, //
                ))
              : (Container()),
          (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == true)
              ? (ShadowBox(
                  icon: Icon(Icons.info_outline),
                  heading: "Status",
                  text: "Rejected",
                  onTapFunction: () {}, //
                ))
              : (Container()),
          (eventDoc.data["isApproved"] == true &&
                  eventDoc.data["isRejected"] == false)
              ? (ShadowBox(
                  icon: Icon(Icons.info_outline),
                  heading: "Status",
                  text: "Approved",
                  onTapFunction: () {}, //
                ))
              : (Container()),
          //eName
          //eDescription
          //eVenue
          //eAttendeesNo
          ShadowBoxList(
            icon: Icon(Icons.event),
            widgetColumn: <Widget>[
              H3(textBody: "Name"),
              BodyText(textBody: eventDoc.data["eName"]),
              SizedBox(height: 5),
              H3(textBody: "Description"),
              BodyText(textBody: eventDoc.data["eDescription"]),
              SizedBox(height: 5),
              H3(textBody: "Venue"),
              BodyText(textBody: eventDoc.data["eVenue"]),
              SizedBox(height: 5),
              H3(textBody: "Participants"),
              BodyText(textBody: eventDoc.data["eAttendeesNo"].toString()),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Name"),
                        BodyText(textBody: eventDoc.data["eName"]),
                        SizedBox(height: 5),
                        eNameTextField,
                        InterTextFieldSpacing(),
                        SizedBox(height: 5),
                        H3(textBody: "Description"),
                        BodyText(textBody: eventDoc.data["eDescription"]),
                        SizedBox(height: 5),
                        eDescriptionTextField,
                        InterTextFieldSpacing(),
                        H3(textBody: "Venue"),
                        BodyText(textBody: eventDoc.data["eVenue"]),
                        SizedBox(height: 5),
                        eVenueTextField,
                        InterTextFieldSpacing(),
                        H3(textBody: "Participants"),
                        BodyText(
                            textBody: eventDoc.data["eAttendeesNo"].toString()),
                        SizedBox(height: 5),
                        eAttendeesNoTextField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "eName": eNameTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "eDescription":
                                      eDescriptionTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "eVenue": eVenueTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "eAttendeesNo":
                                      eAttendeesNoTextField.getReturnValue(),
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
          //eStartDateTimeField
          //eEndDateTimeField
          ShadowBoxList(
            icon: Icon(Icons.timelapse),
            widgetColumn: <Widget>[
              H2(textBody: "Duration"),
              SizedBox(height: 5),
              H3(textBody: "Start Date and Time"),
              BodyText(textBody: eventDoc.data["eStartDateTime"].toString()),
              SizedBox(height: 5),
              H3(textBody: "End Date and Time"),
              BodyText(textBody: eventDoc.data["eEndDateTime"].toString()),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Start Date and Time"),
                        BodyText(
                            textBody:
                                eventDoc.data["eStartDateTime"].toString()),
                        SizedBox(height: 5),
                        eStartDateTimeField,
                        InterTextFieldSpacing(),
                        SizedBox(height: 5),
                        H3(textBody: "End Date and Time"),
                        BodyText(
                            textBody: eventDoc.data["eEndDateTime"].toString()),
                        SizedBox(height: 5),
                        eEndDateTimeField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "eStartDateTime":
                                      eStartDateTimeField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "eEndDateTime":
                                      eEndDateTimeField.getReturnValue(),
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
          //gName
          //gCompany
          ShadowBoxList(
            icon: Icon(Icons.supervisor_account),
            widgetColumn: <Widget>[
              H2(textBody: "Guest Speaker"),
              SizedBox(height: 5),
              H3(textBody: "Name"),
              BodyText(textBody: eventDoc.data["gName"]),
              SizedBox(height: 5),
              H3(textBody: "Company"),
              BodyText(textBody: eventDoc.data["gCompany"]),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Name"),
                        BodyText(textBody: eventDoc.data["gName"].toString()),
                        SizedBox(height: 5),
                        gNameTextField,
                        InterTextFieldSpacing(),
                        SizedBox(height: 5),
                        H3(textBody: "Company"),
                        BodyText(
                            textBody: eventDoc.data["gCompany"].toString()),
                        SizedBox(height: 5),
                        gCompanyTextField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "gName": gNameTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "gCompany":
                                      gCompanyTextField.getReturnValue(),
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
          //oContactNo
          ShadowBoxList(
            icon: Icon(Icons.person_pin),
            widgetColumn: <Widget>[
              H2(textBody: "Organizer"),
              SizedBox(height: 5),
              H3(textBody: "Active Contact Number"),
              SizedBox(height: 5),
              BodyText(textBody: eventDoc.data["oContactNo"]),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Active Contact Number"),
                        BodyText(
                            textBody: eventDoc.data["oContactNo"].toString()),
                        SizedBox(height: 5),
                        oContactNoTextField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "oContactNo":
                                      oContactNoTextField.getReturnValue(),
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
          //selectedRefreshmentType
          //rPersonNo
          //rServeDateTimeField
          ShadowBoxList(
            icon: Icon(Icons.fastfood),
            widgetColumn: <Widget>[
              H2(textBody: "Refreshment"),
              SizedBox(height: 5),
              H3(textBody: "Type"),
              BodyText(
                  textBody:
                      eventDoc.data["selectedRefreshmentType"].toString()),
              SizedBox(height: 5),
              H3(textBody: "Menu Items"),
              BodyText(textBody: eventDoc.data["rMenuItems"].toString()),
              SizedBox(height: 5),
              H3(textBody: "Guest Count"),
              BodyText(textBody: eventDoc.data["rPersonNo"].toString()),
              SizedBox(height: 5),
              H3(textBody: "Serving Date and Time"),
              BodyText(textBody: eventDoc.data["rServeDateTime"].toString()),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Type"),
                        BodyText(
                            textBody: eventDoc.data["selectedRefreshmentType"]
                                .toString()),
                        SizedBox(height: 5),
                        InterTextFieldSpacing(),
                        H3(textBody: "Menu Items"),
                        BodyText(
                            textBody: eventDoc.data["rMenuItems"].toString()),
                        SizedBox(height: 5),
                        rMenuItemsTextField,
                        InterTextFieldSpacing(),
                        H3(textBody: "Guest Count"),
                        BodyText(
                            textBody: eventDoc.data["rPersonNo"].toString()),
                        SizedBox(height: 5),
                        rPersonNoTextField,
                        InterTextFieldSpacing(),
                        H3(textBody: "Serving Date and Time"),
                        BodyText(
                            textBody:
                                eventDoc.data["rServeDateTime"].toString()),
                        SizedBox(height: 5),
                        rServeDateTimeField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "rMenuItems":
                                      rMenuItemsTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "rPersonNo":
                                      rPersonNoTextField.getReturnValue(),
                                });
                                doc.reference.updateData({
                                  "rServeDateTime":
                                      rServeDateTimeField.getReturnValue(),
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
          //selectedServices
          ShadowBoxList(
            icon: Icon(Icons.room_service),
            widgetColumn: <Widget>[
              H2(textBody: "Services Required"),
              SizedBox(height: 5),
              BodyText(textBody: eventDoc.data["selectedServices"].toString()),
            ],
            onTapFunction: () {
              if (eventDoc.data["isApproved"] == false &&
                  eventDoc.data["isRejected"] == false) {
                Alert(
                    context: context,
                    title: "Edit",
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
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: "Services Required"),
                        BodyText(
                            textBody:
                                eventDoc.data["selectedServices"].toString()),
                        SizedBox(height: 5),
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
                        InterTextFieldSpacing(),
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Editing Event:');
                              final doc = eventDoc;
                              if (doc.exists) {
                                doc.reference.updateData({
                                  "selectedServices": selectedServices,
                                });
                              }
                              stopLoading();

                              Navigator.pop(context);
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: 'SAVE',
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
                    ]).show();
              }
            }, //
          ),
        ],
      ),
    );
  }
}
