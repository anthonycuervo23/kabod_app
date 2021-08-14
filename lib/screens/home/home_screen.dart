import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/main.dart';

// my imports
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/commons/customUrlText.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/home/components/Story.dart';
import 'package:kabod_app/screens/home/components/calendar_wod_message.dart';
import 'package:kabod_app/screens/home/components/main_calendar.dart';
import 'package:kabod_app/screens/home/components/popup_menu.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime today;
  DateTime firstDate;
  List<Result> results = [];
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('notification_image');
    var initializationSettingsIOS =
        new IOSInitializationSettings(requestAlertPermission: true);
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> getNotification() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(context, AppRoutes.chatRoute);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (message.data != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          message.data['title'],
          message.data['body'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
          payload: jsonEncode(message),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // notification = message.data;
      AndroidNotification android = message.notification?.android;
      if (message.data != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          message.data['title'],
          message.data['body'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: '@drawable/notification_image',
            ),
          ),
          payload: jsonEncode(message),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, AppRoutes.chatRoute);
    });
  }

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    firstDate = beginningOfDay(DateTime(today.year, today.month, 1));
    getToken();
    FirebaseMessaging.instance.subscribeToTopic('generalNotification');
    configLocalNotification();
    getNotification();
  }

  getToken() async {
    //String token =
    await FirebaseMessaging.instance.getToken().then((token) {
      print('token: $token');
      FirebaseFirestore.instance
          .collection('users')
          .doc(Provider.of<UserRepository>(context, listen: false).user.uid)
          .update({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainScreenModel mainScreenModel =
        Provider.of<MainScreenModel>(context);
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.50),
            child: MyAppBar(
              scaffoldKey: _scaffoldKey,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerBig(),
                        DividerBig(),
                        DividerSmall(),
                        //username
                        Text(
                            userRepository.userModel?.gender == 'Femenino'
                                ? S.of(context).welcomeUserWoman(formatName(
                                    userRepository.userModel?.name ?? ''))
                                : S.of(context).welcomeUserMan(formatName(
                                    userRepository.userModel?.name ?? '')),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kTextColor)),
                        //stories
                        Container(
                          height: 55,
                          width: size.width,
                          child: Story(userId: userRepository?.userModel?.id),
                        ),
                        DividerSmall(),
                        WodCalendar(),
                        DividerSmall(),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: TabBar(indicatorColor: kButtonColor, tabs: [
                Tab(text: 'WOD'),
                Tab(text: S.of(context).appBarSchedule)
              ]),
            ),
          ),
          drawer: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: MyDrawer(AppRoutes.homeRoute),
          ),
          floatingActionButton: userRepository.userModel?.admin == true
              ? FloatingActionButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.addWodRoute),
                  child: Icon(
                    Icons.add,
                    color: kBackgroundColor,
                    size: 40,
                  ),
                )
              : Container(),
          body: TabBarView(
            children: [
              StreamBuilder<List<Wod>>(
                  stream: mainScreenModel.wodStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final List<Wod> wods = snapshot.data;
                      mainScreenModel.groupWods(wods);
                      return Column(
                        children: [
                          DividerMedium(),
                          Text(
                              DateFormat('EEEE, d MMM y')
                                  .format(mainScreenModel.selectedDate)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 28, color: kWhiteTextColor)),
                          DividerMedium(),
                          displayWodList(wods, mainScreenModel)
                        ],
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    kButtonColor)));
                      default:
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    kButtonColor)));
                    }
                  }),
              StreamBuilder<List<Classes>>(
                stream: mainScreenModel.classesStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final List<Classes> classes = snapshot.data;
                    mainScreenModel.groupClasses(classes);
                    return Column(
                      children: [
                        DividerMedium(),
                        Text(
                            DateFormat('EEEE, d MMM y')
                                .format(mainScreenModel.selectedDate)
                                .toString(),
                            style: TextStyle(
                                fontSize: 28, color: kWhiteTextColor)),
                        DividerMedium(),
                        displayHoursList(
                            classes, mainScreenModel, userRepository)
                      ],
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kButtonColor)));
                    default:
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kButtonColor),
                      ));
                  }
                },
              ),
            ],
          )),
    );
  }

  Widget displayHoursList(List<Classes> allClasses,
      MainScreenModel mainScreenModel, UserRepository userRepository) {
    List<Classes> selectedClasses = allClasses
        .where((element) =>
            mainScreenModel.selectedDate.day == element.classDate.day)
        .toList();
    if (selectedClasses.length < 1) {
      return Center(
          child: Text(
        S.of(context).scheduleNotAvailable,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ));
    } else if (selectedClasses[0].classDate.weekday == 7) {
      return Center(
          child: Text(
        S.of(context).noClassesToday,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ));
    }
    return Expanded(
      child: ListView.builder(
          itemCount: selectedClasses[0].classAthletes.keys.length,
          itemBuilder: (BuildContext context, int index) {
            List<String> listOfClasses =
                selectedClasses[0].classAthletes.keys.toList();

            listOfClasses.sort((a, b) {
              return a.compareTo(b);
            });

            List<DateTime> listOfHours = dateTimeFromStrings(listOfClasses);

            return InkWell(
              onTap: () => Navigator.pushNamed(
                  context, AppRoutes.classDetailsRoute,
                  arguments: [
                    selectedClasses[0],
                    listOfHours,
                    index,
                  ]),
              child: DefaultCard(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          DateFormat.jm()
                              .format(listOfHours[index])
                              .toString()
                              .toLowerCase(),
                          style:
                              TextStyle(fontSize: 22, color: kWhiteTextColor),
                        ),
                        selectedClasses[0]
                                .classAthletes[listOfClasses[index]]
                                .contains(userRepository.user?.uid.toString())
                            ? Text(S.of(context).registered)
                            : Container(),
                      ],
                    ),
                    Flexible(
                      child: ListTile(
                        title: Text(
                          listOfHours[index].hour == 11 ||
                                  listOfHours[index].hour == 10
                              ? 'Open Box'
                              : S.of(context).crossfitClass,
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: selectedClasses[0]
                                    .classAthletes[listOfClasses[index]]
                                    .length ==
                                selectedClasses[0].maxAthletes
                            ? Text(
                                S.of(context).completed,
                                style: TextStyle(
                                    color: kButtonColor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                S.of(context).athletesInClass(
                                    selectedClasses[0]
                                        .classAthletes[listOfClasses[index]]
                                        .length,
                                    selectedClasses[0].maxAthletes),
                                style: TextStyle(color: kTextColor),
                                textAlign: TextAlign.center,
                              ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 28,
                          color: kButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget displayWodList(List<Wod> allWods, MainScreenModel mainScreenModel) {
    final df = DateFormat('dd/MM/yyyy');
    List<Wod> selectedWods = allWods
        .where(
            (element) => mainScreenModel.selectedDate.day == element.date.day)
        .toList();
    if (Provider.of<UserRepository>(context, listen: false).userModel.admin) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: selectedWods.length,
          itemBuilder: (BuildContext context, int index) {
            Wod wod = selectedWods[index];
            print(index);
            return DefaultCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    child: ListTile(
                      title: Text(wod.title,
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor)),
                      subtitle: Text(wod.type, style: TextStyle(fontSize: 18)),
                      trailing: Container(
                          width: 100,
                          height: 100,
                          child: PopupWodMenu(
                            currentWod: wod,
                          )),
                    ),
                  ),
                  DividerSmall(),
                  UrlText(
                      text: wod.description, style: TextStyle(fontSize: 20)),
                  DividerSmall(),
                ],
              ),
            );
          },
        ),
      );
    } else if (mainScreenModel.selectedDate.weekday == 7) {
      return RestDayMessage();
    } else if (mainScreenModel.selectedDate.isBefore(firstDate)) {
      return Center(
          child: Text(
        S.of(context).wodNotAvailable,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ));
    } else if (mainScreenModel.selectedDate
        .isAfter(today.add(Duration(days: 1)))) {
      return Center(
        child: Text(
          S
              .of(context)
              .wodAvailableDate(df.format(mainScreenModel.selectedDate)),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: selectedWods.length,
          itemBuilder: (BuildContext context, int index) {
            Wod wod = selectedWods[index];
            print(index);
            return DefaultCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    child: ListTile(
                      title: Text(wod.title,
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor)),
                      subtitle: Text(wod.type, style: TextStyle(fontSize: 18)),
                      trailing: Container(
                          width: 100,
                          height: 100,
                          child: PopupWodMenu(currentWod: wod)),
                    ),
                  ),
                  DividerSmall(),
                  UrlText(
                      text: wod.description, style: TextStyle(fontSize: 20)),
                  DividerSmall(),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
