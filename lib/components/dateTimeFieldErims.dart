import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateTimeFieldErims extends StatefulWidget {
  DateTimeFieldErims({
    this.labelText,
  });
  final String labelText;
  DateTime retValue;

  @override
  _DateTimeFieldErimsState createState() => _DateTimeFieldErimsState();

  DateTime getReturnValue() => retValue;
}

class _DateTimeFieldErimsState extends State<DateTimeFieldErims> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      color: Color(0xfff5f5f5),
      child: DateTimeField(
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'SFUIDisplay',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText,
          prefixIcon: Icon(Icons.calendar_today),
          labelStyle: TextStyle(fontSize: 15),
        ),
        format: DateFormat("dd/MM/yyyy hh:mm").add_jm(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            widget.retValue = DateTimeField.combine(date, time);
          } else {
            widget.retValue = currentValue;
          }
          return widget.retValue;
        },
      ),
    );
  }
}
