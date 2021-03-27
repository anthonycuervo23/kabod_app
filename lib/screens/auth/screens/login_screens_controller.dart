import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/auth/model/user_repository.dart';
import 'package:kabod_app/screens/auth/screens/login_screen.dart';
import 'package:kabod_app/screens/auth/screens/splash.dart';
import 'package:kabod_app/screens/home//home_screen.dart';
import 'package:kabod_app/screens/auth/screens/intro_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    switch (user.status) {
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        if (user.isLoading) return Splash();
        return user.userModel?.introSeen ?? false
            ? HomeScreen()
            : IntroScreen();
      case Status.Uninitialized:
      default:
        return Splash();
    }
  }
}
