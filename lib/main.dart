import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//my imports
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/service/sharedPreferences.dart';
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
import 'package:kabod_app/core/repository/results_repository.dart';

import 'service/notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ),
      payload: json.encode(message));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
);

NotificationAppLaunchDetails notifLaunch;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  await Firebase.initializeApp();
  await sharedPrefs.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  notifLaunch =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
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
        ChangeNotifierProvider(
          create: (_) {
            DateTime today = DateTime.now();
            // final firstDayOfTheWeek = today
            //     .subtract(Duration(days: today.weekday))
            //     .millisecondsSinceEpoch;
            final lastDayOfTheWeek = today
                .add(Duration(days: 7 - today.weekday))
                .millisecondsSinceEpoch;
            final DateTime firstDate =
                beginningOfDay(DateTime(today.year, today.month, 1));
            DateTime lastDate = endOfDay(lastDayOfMonth(today));
            Stream<List<Classes>> _classesStream =
                ClassesRepository(FirebaseFirestore.instance)
                    .getClassesOfTheDay(
                        firstDate.millisecondsSinceEpoch, lastDayOfTheWeek);
            Stream<List<Wod>> _wodsStream =
                WodRepository(FirebaseFirestore.instance).getWods(
                    firstDate.millisecondsSinceEpoch,
                    lastDate.millisecondsSinceEpoch);
            return MainScreenModel(
                selectedDate: DateTime.now(),
                wodStream: _wodsStream,
                classesStream: _classesStream);
          },
        ),
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
