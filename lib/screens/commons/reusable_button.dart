import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';

class ReusableButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  ReusableButton({@required this.onPressed, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kButtonColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
