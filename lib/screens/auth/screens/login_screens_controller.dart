import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/auth/data/user_repository.dart';
import 'package:kabod_app/screens/auth/screens/login_screen.dart';
import 'package:kabod_app/screens/auth/screens/splash.dart';
import 'package:kabod_app/screens/home/screens/home_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    switch (user.status) {
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return HomeScreen();
      case Status.Uninitialized:
      default:
        return Splash();
    }
  }
}
