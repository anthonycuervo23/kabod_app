import 'package:flutter/material.dart';
import 'file:///C:/Users/antho/Desktop/kabod_project/kabod_app/lib/core/presentation/res/constants.dart';
import 'file:///C:/Users/antho/Desktop/kabod_project/kabod_app/lib/features/auth/presentation/screens/login_screen.dart';

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
