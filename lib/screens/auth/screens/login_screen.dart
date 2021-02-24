import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/auth/components/login_form.dart';
import 'package:kabod_app/screens/auth/components/logo.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_background.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
                kBackgroundColor.withOpacity(0.9),
                kBackgroundColor,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          GetLogo(),
          GetLoginForm(),
        ],
      ),
    );
  }
}
