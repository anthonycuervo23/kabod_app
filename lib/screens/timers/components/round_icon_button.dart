import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onTap});
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      constraints: BoxConstraints.tightFor(
        width: 75,
        height: 75,
      ),
      shape: CircleBorder(),
      fillColor: kButtonColor,
      child: Icon(icon, size: 50),
    );
  }
}
