import 'package:erims/components/h2.dart';

import 'sizeConfig.dart';
import 'package:flutter/material.dart';

class RequestBackCard extends StatelessWidget {
  final Function onPhoneTapped;
  const RequestBackCard({
    Key key,
    @required this.onPhoneTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      width: SizeConfig.horizontalBloc * 90,
      height: SizeConfig.safeBlockVertical * 3,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: H2(
        textBody: "View Event Details  >",
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
