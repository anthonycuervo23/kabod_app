import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/screens/auth/screens/login_screens_controller.dart';
import 'package:kabod_app/screens/auth/screens/reset_password_screen.dart';
import 'package:kabod_app/screens/classes/class_details_screen.dart';
import 'package:kabod_app/screens/home/home_screen.dart';
import 'package:kabod_app/screens/leaderboard/leaderboard_screen.dart';
import 'package:kabod_app/screens/leaderboard/picture_details_screen.dart';
import 'package:kabod_app/screens/personal_records/edit_result_screen.dart';
import 'package:kabod_app/screens/personal_records/pr_results_screen.dart';
import 'package:kabod_app/screens/personal_records/pr_screen.dart';
import 'package:kabod_app/screens/results/add_results.dart';
import 'package:kabod_app/screens/wods/wod_editor_screen.dart';

class AppRoutes {
  static const String loginRoute = '/';
  static const String ResetPasswordRoute = '/reset_password';
  static const String homeRoute = '/home';
  static const String addWodRoute = '/add_wod';
  static const String editWodRoute = '/edit_wod';
  static const String classDetailsRoute = '/class_details';
  static const String addWodResultsRoute = '/add_wod_results';
  static const String leaderBoardRoute = '/leaderBoard';
  static const String pictureDetailsRoute = '/pictureDetails';
  static const String personalRecordsRoute = '/personalRecords';
  static const String resultsRoute = '/resultsRoute';
  static const String addResultRoute = '/addResultRoute';
  static const String editResultRoute = '/editResultRoute';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editResultRoute:
        List<dynamic> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EditResultDetailsScreen(
                currentResult: args[0], selectedExercise: args[1]));
      case addResultRoute:
        return MaterialPageRoute(
            builder: (_) =>
                EditResultDetailsScreen(selectedExercise: settings.arguments));
      case resultsRoute:
        return MaterialPageRoute(
            builder: (_) =>
                ResultsScreen(selectedExercise: settings.arguments));
      case personalRecordsRoute:
        return MaterialPageRoute(builder: (_) => PersonalRecordsScreen());
      case pictureDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => PictureDetailsScreen(picture: settings.arguments));
      case leaderBoardRoute:
        return MaterialPageRoute(builder: (_) => LeaderBoardScreen());
      case addWodResultsRoute:
        return MaterialPageRoute(
            builder: (_) => AddResultsScreen(currentWod: settings.arguments));
      case classDetailsRoute:
        List<dynamic> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ClassDetailScreen(
                currentClass: args[0], listOfHours: args[1], index: args[2]));
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
