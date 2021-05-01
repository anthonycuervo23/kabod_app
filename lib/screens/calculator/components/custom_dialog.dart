import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Widget listOfPlates;

  const CustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.listOfPlates})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      margin: EdgeInsets.only(top: 45),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: kButtonColor),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.descriptions,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          widget.listOfPlates,
          Text(widget.text, style: TextStyle(fontSize: 16)),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                      fontSize: 18,
                      color: kButtonColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
