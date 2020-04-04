import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'components/buttonErims.dart';
import 'components/h2.dart';

// ignore: must_be_immutable
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String _categoryFT;
  bool dropDownFT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RFlutter Alert by Ratel'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                            items: snapshot.data.documents.map(
                                                (DocumentSnapshot document) {
                                              return DropdownMenuItem<String>(
                                                  value: document.data['email'],
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10.0,
                                                            2.0,
                                                            10.0,
                                                            0.0),
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
                          ButtonErims(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                print('User Forwarding Event:');
                                stopLoading();
                              } else {
                                stopLoading();
                              }
                            },
                            labelText: 'PROCEED',
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          color: Colors.white,
                        ),
                      ]).show() //widget.onAccep
              ),
        ),
      ),
    );
  }
}
