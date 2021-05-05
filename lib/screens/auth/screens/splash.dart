import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      child: Hero(
        tag: 'logo',
        child: Center(
          child: Image.asset('assets/images/logo_white.png',
              width: MediaQuery.of(context).size.width * 0.40),
        ),
      ),
    );
  }
}
