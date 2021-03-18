import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/screens/auth/screens/login_screens_controller.dart';
import 'package:kabod_app/screens/auth/screens/reset_password_screen.dart';
import 'package:kabod_app/screens/classes/classes_screen.dart';
import 'package:kabod_app/screens/home/home_screen.dart';
import 'package:kabod_app/screens/wods/wod_editor_screen.dart';

class AppRoutes {
  static const String loginRoute = '/';
  static const String ResetPasswordRoute = '/reset_password';
  static const String homeRoute = '/home';
  static const String addWodRoute = '/add_wod';
  static const String editWodRoute = '/edit_wod';
  static const String classesRoute = '/classes';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case classesRoute:
        return MaterialPageRoute(builder: (_) => ClassesScreen());
      case editWodRoute:
        return MaterialPageRoute(
            builder: (_) => WodEditorScreen(currentWod: settings.arguments));
      case addWodRoute:
        return MaterialPageRoute(builder: (_) => WodEditorScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case ResetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
