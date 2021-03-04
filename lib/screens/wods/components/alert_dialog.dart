import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class AlertDialogWod extends StatelessWidget {
  final String content;
  const AlertDialogWod({
    this.content,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('ERROR',
          style: TextStyle(
              color: kButtonColor, fontSize: 30, fontWeight: FontWeight.bold)),
      content: Text(content),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('Close'))
      ],
    );
  }
}
