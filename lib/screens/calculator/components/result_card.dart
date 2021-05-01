import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class ResultCard extends StatelessWidget {
  final double weight;
  final int reps;

  const ResultCard({@required this.weight, @required this.reps, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(this.reps.toString() + "RM",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kButtonColor,
            )),
        Text(this.weight.roundToDouble().toString(),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        Text("lb")
      ],
    );
  }
}
