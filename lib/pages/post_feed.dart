import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/models/event.dart';
import 'package:erims/components/header.dart';
import 'package:erims/components/progress.dart';
import 'package:flutter/material.dart';

class PostFeed extends StatefulWidget {
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  final eventRef = Firestore.instance
      .collection('events')
      .where('isApproved', isEqualTo: true)
      .where('isRejected', isEqualTo: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, false),
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: eventRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return linearProgress(context);
            }
            final List<Widget> children = snapshot.data.documents
                .map(
                  (doc) =>
                      Event.fromFirebaseDocument(doc).toPostFeedItem(context),
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
      ),
    );
  }
}
