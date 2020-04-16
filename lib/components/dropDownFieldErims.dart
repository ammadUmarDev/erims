import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownFieldErims extends StatefulWidget {
  Text selectedValue;
  List<Text> options = [];

  DropDownFieldErims(List<String> options, {String defaultHeading = ""}) {
    for (var option in options) {
      this.options.add(Text(option));
      print(option);
    }
    selectedValue = Text(defaultHeading);
  }

  String getSelectedValue() => selectedValue.data;

  @override
  _DropDownFieldErimsState createState() => _DropDownFieldErimsState();
}

class _DropDownFieldErimsState extends State<DropDownFieldErims> {
  @override
  Widget build(BuildContext context) {
    /*final dataSource = widget.options
        .map((e) => {"display": e.data, "value": e.data})
        .toList();*/

    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Colors.grey[500],
        ),
      ),
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
                value: widget.selectedValue,
                onChanged: (Text value) {
                  setState(() {
                    //widget.selectedValue = value;
                  });
                },
                items: widget.options.map((Text refreshmentType) {
                  return DropdownMenuItem<Text>(
                    value: refreshmentType,
                    child: Row(
                      children: <Widget>[
                        Text(
                          refreshmentType.data,
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
    );
    /*DropDownFormField(
      titleText: widget.selectedValue,
      hintText: 'Please choose one',
      value: widget.selectedValue,
      /*onSaved: (value) {
        setState(() {
          widget.selectedValue = Text(value);
        });
      },*/
      onChanged: (value) {
        setState(() {
          widget.selectedValue = value;
        });
      },
      dataSource: dataSource,
      textField: 'display',
      valueField: 'value',
    );*/
  }
}
