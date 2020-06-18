import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/header.dart';
import 'package:erims/models/user.dart';
import 'package:file_picker/file_picker.dart';
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
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:path/path.dart' as Path;
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
  File _file;
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future chooseFile() async {
    await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['pdf'])
        .then((file) {
      setState(() {
        _file = file;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('eventDocumentUpload/${Path.basename(_file.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
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
      _showDialog();
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
    //keyboardType: TextInputType.multiline,
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
  /*DropDownFieldErims selectRefreshmentType = DropDownFieldErims(
    refreshmentType,
    defaultHeading: 'Refreshment Type',
  );*/
  String selectRefreshmentType;
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
  /*AttachmentFieldErims eventAttachment = AttachmentFieldErims(
    title: 'Event Attachments',
  );*/

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
                /*InterTextFieldSpacing(),
                eventAttachment,*/
                InterTextFieldSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        H2(
                          textBody: 'Attach a Document (optional)',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        _file == null
                            ? RaisedButton(
                                child: Icon(
                                  Icons.search,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                onPressed: chooseFile,
                                color: Colors.white,
                              )
                            : Container(),
                        /*_file != null
                            ? RaisedButton(
                                child: Icon(
                                  Icons.cloud_upload,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                onPressed: uploadFile,
                                color: Colors.white,
                              )
                            : Container(),*/
                        _file != null
                            ? RaisedButton(
                                child: Icon(
                                  Icons.clear,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _file = null;
                                  });
                                },
                                color: Colors.white,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                InterTextFieldSpacing(),
                Column(
                  children: <Widget>[
                    _file != null
                        ? Text(_file.path.toString())
                        : Container(height: 50),
                    /*_uploadedFileURL != null
                        ? Text(
                            _uploadedFileURL.toString(),
                          )
                        : Container(),*/
                  ],
                ),
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
                H1(
                  textBody: 'Please Verfiy Your Input.',
                ),
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
                        setState(() {
                          Firestore.instance
                              .collection('users')
                              .where('email', isEqualTo: _categoryFT)
                              .snapshots()
                              .listen((QuerySnapshot querySnapshot) {
                            querySnapshot.documents.forEach((document) {
                              forwardToUser = document.documentID;
                              print("inside forEach" + forwardToUser);
                            });
                          });
                        });
                        print(_categoryFT);
                        print("before creating event object " + forwardToUser);
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
                          userObj.department.toString(),
                          userObj.fullName.toString(),
                          oContactNoTextField.getReturnValue(),
                          rMenuItemsTextField.getReturnValue(),
                          int.parse(rPersonNoTextField.getReturnValue()),
                          rServeDateTimeField.getReturnValue(),
                          "High Tea",
                          selectedServices,
                          userId,
                          false,
                          forwardToUser,
                          false,
                          _file,
                          null,
                        );
                        print("after creating event object " + forwardToUser);
                        if (createdEvent != null) {
                          try {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmCreateEvent(
                                        createdEvent: createdEvent)));
                          } catch (e) {
                            print("Unable to push to confirm.");
                            _showDialog();
                          }
                        }
                      } catch (e) {
                        print(e);
                        _showDialog();
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
            "Unable to create event. Invalid Input. Please try again later."), //TODO: make dialog pretty
      ),
    );
  }
}
