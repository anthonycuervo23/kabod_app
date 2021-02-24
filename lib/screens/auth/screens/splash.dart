import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: Hero(
        tag: 'logo',
        child: Center(
          child: Image.asset('assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.25),
        ),
      ),
    );
  }
}
