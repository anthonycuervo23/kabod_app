import 'package:flutter/material.dart';

class GetLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/images/logo_white.png',
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }
}
