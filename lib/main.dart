import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/navigationDrawer/model/drawer_notifier.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/core/repository/classes_repository.dart';
import 'package:kabod_app/core/repository/intro_profile_repository.dart';
import 'package:kabod_app/core/repository/wod_repository.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

import 'core/repository/results_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kButtonColor,
            elevation: 0,
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          fontFamily: 'Nunito',
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.loginRoute,
      ),
      providers: [
        ChangeNotifierProvider(
            create: (_) => IntroRepository(
                FirebaseFirestore.instance, FirebaseStorage.instance)),
        ChangeNotifierProvider(create: (_) => UserRepository.instance()),
        ChangeNotifierProvider(create: (_) {
          DateTime today = DateTime.now();
          final firstDayOfTheWeek = today
              .subtract(Duration(days: today.weekday))
              .millisecondsSinceEpoch;
          final lastDayOfTheWeek = today
              .add(Duration(days: 7 - today.weekday))
              .millisecondsSinceEpoch;
          DateTime firstDate =
              beginningOfDay(DateTime(today.year, today.month, 1));
          Stream<List<Classes>> _classesStream =
              ClassesRepository(FirebaseFirestore.instance)
                  .getClassesOfTheDay(firstDayOfTheWeek, lastDayOfTheWeek);
          Stream<List<Wod>> _wodsStream =
              WodRepository(FirebaseFirestore.instance).getWods(
                  firstDate.millisecondsSinceEpoch,
                  today.millisecondsSinceEpoch);
          return MainScreenModel(
              selectedDate: DateTime.now(),
              wodStream: _wodsStream,
              classesStream: _classesStream);
        }),
        Provider<WodRepository>(
            create: (_) => WodRepository(FirebaseFirestore.instance)),
        Provider<ClassesRepository>(
            create: (_) => ClassesRepository(FirebaseFirestore.instance)),
        ChangeNotifierProvider<ResultRepository>(
            create: (_) => ResultRepository(FirebaseFirestore.instance)),
        ChangeNotifierProvider<DrawerStateInfo>(
            create: (_) => DrawerStateInfo()),
      ],
    );
  }
}
