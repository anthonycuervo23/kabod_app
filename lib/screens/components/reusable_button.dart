import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class ReusableButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  ReusableButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: RaisedButton(
        color: kButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: kWhiteTextColor,
              // fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}
