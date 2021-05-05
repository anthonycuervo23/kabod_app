import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';

//my imports
import 'package:kabod_app/screens/commons/dividers.dart';

class RestDayMessage extends StatelessWidget {
  const RestDayMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            child: Image.asset(
              'assets/images/rest_day.jpg',
              fit: BoxFit.cover,
            ),
          ),
          DividerSmall(),
          Text(
            S.of(context).restDayMessage1,
            style: TextStyle(fontSize: 18),
          ),
          DividerSmall(),
          Text(S.of(context).restDayMessage2, style: TextStyle(fontSize: 18)),
          DividerSmall(),
          Text(S.of(context).restDayMessage3, style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}
