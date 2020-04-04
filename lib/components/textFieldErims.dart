import 'package:erims/components/bodyText.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldErims extends StatefulWidget {
  TextEditingController _textEditingController = TextEditingController();

  TextFieldErims({
    this.textFieldIcon = const Icon(
      Icons.keyboard,
    ),
    this.textFieldText,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.isValidEntry,
  }) {
    if (isValidEntry == null) {
      isValidEntry = (dynamic a) {
        return '';
      };
    }
  }
  final Icon textFieldIcon;
  final String textFieldText;
  final bool obscure;
  final TextInputType keyboardType;
  dynamic retValue;
  String Function(dynamic)
      isValidEntry; //checks if the entry complies with pre set restrictions

  @override
  _TextFieldErimsState createState() => _TextFieldErimsState();

  dynamic getReturnValue() => retValue;
}

class _TextFieldErimsState extends State<TextFieldErims> {
  Color color = Color(0xfff5f5f5);
  String warningMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 55.0,
          color: color,
          child: TextFormField(
            style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.textFieldText,
              prefixIcon: widget.textFieldIcon,
              labelStyle: TextStyle(fontSize: 15),
            ),
            keyboardType: widget.keyboardType,
            maxLines:
                (widget.keyboardType == TextInputType.multiline) ? null : 1,
            obscureText: widget.obscure,
            controller: widget._textEditingController,
            onChanged: (value) {
              setState(() {
                warningMessage = widget.isValidEntry(value);
                print(warningMessage);
                if (warningMessage == '') {
                  widget.retValue = value;
                  color = Color(0xfff5f5f5);
                } else {
                  color = Color(0xfff5f5f5);
                }
              });
            },
          ),
        ),
        (warningMessage != '')
            ? (Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 2.0),
                child: Text(
                  warningMessage,
                  textAlign: TextAlign.left,
                  style: BodyTextStyle(color: Colors.red),
                ),
              ))
            : (Container(
                height: 0.0,
              )),
      ],
    );
  }
}
