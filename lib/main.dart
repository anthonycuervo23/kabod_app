import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/classes/repository/classes_repository.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/screens/home/repository/wod_repository.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';

import 'core/utils/calendar.dart';

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
        ChangeNotifierProvider(create: (_) => UserModel.instance()),
        ChangeNotifierProvider(create: (_) {
          DateTime today = DateTime.now();
          DateTime firstDate =
              beginningOfDay(DateTime(today.year, today.month, 1));
          Stream<List<Classes>> _classesStream =
              ClassesRepository(FirebaseFirestore.instance)
                  .getClassesOfTheDay();
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
      ],
    );
  }
}
