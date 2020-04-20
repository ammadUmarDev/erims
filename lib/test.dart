/*
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/h1.dart';
import 'package:erims/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EventEmail extends StatefulWidget {
  EventEmail({this.eventID, this.currentUser});
  final eventID;
  final currentUser;

  @override
  _EventEmailState createState() => _EventEmailState();
}

class _EventEmailState extends State<EventEmail> {
  List<String> attachments = [];
  bool isHTML = false;
  FirebaseUser loggedInUser;
  var documentRef = Firestore.instance.collection("events");
  DocumentSnapshot eventDoc;
  final _auth = FirebaseAuth.instance;

  var _recipientController;
  */
/*= TextEditingController(
    text: 'ammad.umar@outlook.com,i170092@nu.edu.pk',
  );*/ /*

  var _subjectController; */
/*= TextEditingController(text: 'Event '+eventDoc.data["eStartDateTimeField"]+' Approved!');*/ /*

  var _bodyController;
  */
/*= TextEditingController(
    text: 'Ignore, we are testing.',
  );*/ /*


  @override
  void initState() {
    getEventDoc();

    super.initState();
  }

  void getEventDoc() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        final DocumentSnapshot tempdoc = await Firestore.instance
            .collection('events')
            .document(widget.eventID)
            .get();
        if (tempdoc != null) {
          eventDoc = tempdoc;
          setState(() {
            _recipientController = TextEditingController(
              text: "asd",
            );
            _subjectController = TextEditingController(
                text: 'Event ' + eventDoc.data["eName"] + ' Approved!');
            _bodyController = TextEditingController(
                text: "Event Details:" +
                    "\n" +
                    "\n" +
                    "Name: " +
                    eventDoc.data["eName"].toString() +
                    "\n" +
                    "Description: " +
                    eventDoc.data["eDescription"].toString() +
                    "\n" +
                    "Venue: " +
                    eventDoc.data["eVenue"].toString() +
                    "\n" +
                    "Participant Count: " +
                    eventDoc.data["eAttendeesNo"].toString() +
                    "\n" +
                    "Start Date/Time: " +
                    eventDoc.data["eStartDateTimeField"].toString() +
                    "\n" +
                    "End Date/Time: " +
                    eventDoc.data["eEndDateTimeField"].toString() +
                    "\n" +
                    "\n" +
                    "Event Guest Details" +
                    "\n" +
                    "Name: " +
                    eventDoc.data["gName"].toString() +
                    "\n" +
                    "Company/Organization: " +
                    eventDoc.data["gCompany"].toString() +
                    "\n" +
                    "\n" +
                    "Event Organizer Details" +
                    "\n" +
                    "Organizer Active Contact Number: " +
                    eventDoc.data["oContactNo"].toString() +
                    "\n" +
                    "\n" +
                    "Refreshment Details" +
                    "\n" +
                    "Selected Type: " +
                    eventDoc.data["selectedRefreshmentType"].toString() +
                    "\n" +
                    "Menu Items: " +
                    eventDoc.data["rMenuItems"].toString() +
                    "\n" +
                    "Guest Count: " +
                    eventDoc.data["rPersonNo"].toString() +
                    "\n" +
                    "Serving Date/Time: " +
                    eventDoc.data["rServeDateTime"].toString() +
                    "\n" +
                    "\n" +
                    "Requested Services" +
                    "\n" +
                    "Services Type: " +
                    eventDoc.data["selectedServices"].toString() +
                    "\n" +
                    "\n" +
                    "Please make neccessary arangements." +
                    "\n" +
                    "\n" +
                    "Regards,"
                */
/*"\n" +
                    widget.currentUser["fullName"] +
                    "\n" +
                    widget.currentUser["designation"]);*/ /*

                );
          });

          print(eventDoc.data["eName"]);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
    if (!mounted) return;
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "E.R.I.M.S",
          style: TextStyle(
            fontFamily: "Cantarell",
            fontSize: 23.0,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 45.0,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: H1(
                textBody: "Auto - Generated Email",
                color: Theme.of(context).primaryColor,
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Recipient',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: 30,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
              */
/*...attachments.map(
                (item) => Text(
                  item,
                  overflow: TextOverflow.fade,
                ),
              ),*/ /*

            ],
          ),
        ),
      ),
      */
/*floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.find_in_page),
        label: Text('Attach Document'),
        onPressed: _openDocumentPicker,
      ),*/ /*

    );
  }

*/
/* void _openDocumentPicker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      attachments.add(pick.path);
    });
  }*/ /*

}
*/
