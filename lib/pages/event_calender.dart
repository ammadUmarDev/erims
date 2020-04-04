import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/header.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:erims/models/event.dart';

class EventCalender extends StatefulWidget {
  @override
  _EventCalenderState createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  final _calendarController = CalendarController();
  final eventRef = Firestore.instance.collection('events');
  List<Event> _events = [];
  List<Event> _selectedEvents = [];

  void getEvents() async {
    //_events=[];
    Stream<QuerySnapshot> allSnapshots = eventRef.snapshots();
    await for (var snapshot in allSnapshots) {
      for (var document in snapshot.documents) {
        try {
          final event = Event.fromFirebaseDocument(document);
          _events.add(event);
        } on Exception catch (e) {
          // TODO
        }
      }
    }
  }

  @override
  void dispose() {
    //_animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    Map<DateTime, List<Event>> map = Map<DateTime, List<Event>>();
    _events.forEach(
      (e) {
        if (map.containsKey(e.eStartDateTime)) {
          map[e.eStartDateTime].add(e);
        } else {
          final list = [e];
          map[e.eStartDateTime] = list;
        }
      },
    );

    List<Widget> children = <Widget>[
      TableCalendar(
        calendarController: _calendarController,
        events: map,
        //holidays: _holidays,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedColor:
              Theme.of(context).accentColor, //Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown[700],
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
          formatButtonDecoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onDaySelected: (DateTime day, List events) {
          print('CALLBACK: _onDaySelected');
          setState(() {
            if (events.length == 0)
              _selectedEvents = List<Event>();
            else
              _selectedEvents = events;
            _selectedEvents.forEach(
              (element) {
                print(element.eName);
              },
            );
          });
        },
        onCalendarCreated: (first, last, format) {
          print('CALLBACK: _onCalendarCreated');
          getEvents();
        },
      ),
    ];
    children.addAll(_selectedEvents
        .map(
          (e) => e.toPostFeedItem(context),
        )
        .toList());

    return Scaffold(
      appBar: header(context, false),
      body: ListView(
        children: children,
      ),
    );
  }
}
