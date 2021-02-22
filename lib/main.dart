import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/auth/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        fontFamily: 'Nunito',
      ),
      home: LoginScreen(),
    );
  }
}
