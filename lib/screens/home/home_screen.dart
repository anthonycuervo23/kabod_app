import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:provider/provider.dart';

// my imports
import 'package:kabod_app/core/utils/calendar.dart';
import 'package:kabod_app/screens/home/components/calendar_wod_message.dart';
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/home/components/wod_calendar.dart';
import 'package:kabod_app/screens/home/components/popup_menu.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime today;
  DateTime firstDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    firstDate = beginningOfDay(DateTime(today.year, today.month, 1));
  }

  @override
  Widget build(BuildContext context) {
    final MainScreenModel mainScreenModel =
        Provider.of<MainScreenModel>(context);
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.42),
            child: MyAppBar(
              scaffoldKey: _scaffoldKey,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back, Jean!',
                            style: TextStyle(color: kTextColor)),
                        DividerBig(),
                        WodCalendar(),
                        DividerSmall(),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                  indicatorColor: kButtonColor,
                  tabs: [Tab(text: 'Schedule'), Tab(text: 'WOD')]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.addWodRoute),
            child: Icon(
              Icons.add,
              color: kBackgroundColor,
              size: 40,
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<List<Classes>>(
                stream: mainScreenModel.classesStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final List<Classes> classes = snapshot.data;
                    mainScreenModel.groupClasses(classes);
                    // final List<String> classHours =
                    //     classes[1].classAthletes.keys.toList();
                    return displayHoursList(classes, mainScreenModel);
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              StreamBuilder<List<Wod>>(
                  stream: mainScreenModel.wodStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final List<Wod> wods = snapshot.data;
                      mainScreenModel.groupWods(wods);
                      return Column(
                        children: [
                          DividerMedium(),
                          Text('Today\'s WOD',
                              style: TextStyle(
                                  fontSize: 28, color: kWhiteTextColor)),
                          DividerMedium(),
                          displayWodList(wods, mainScreenModel)
                        ],
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          )),
    );
  }

  Widget displayHoursList(
      List<Classes> allClasses, MainScreenModel mainScreenModel) {
    List<Classes> selectedClasses = allClasses
        .where((element) =>
            mainScreenModel.selectedDate.day == element.classDate.day)
        .toList();
    final List<String> classHours =
        selectedClasses[1].classAthletes.keys.toList();
    return Expanded(
      child: ListView.builder(
          itemCount: selectedClasses[1].startingHours.length,
          itemBuilder: (BuildContext context, int index) {
            final String currentClassHour = classHours[index];
            return InkWell(
              onTap: () => Navigator.pushNamed(
                  context, AppRoutes.classDetailsRoute,
                  arguments: [selectedClasses[1], index]),
              child: DefaultCard(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          DateFormat.jm()
                              .format(selectedClasses[1].startingHours[index])
                              .toString()
                              .toLowerCase(),
                          style:
                              TextStyle(fontSize: 22, color: kWhiteTextColor),
                        ),
                        Text(DateFormat('E d, MMM')
                            .format(selectedClasses[1].classDate)
                            .toString()),
                      ],
                    ),
                    Flexible(
                      child: ListTile(
                        title: Text(
                          selectedClasses[1].startingHours[index].hour != 12
                              ? 'CrossFit Class'
                              : 'Open Box',
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor),
                        ),
                        subtitle: Text(
                          '${selectedClasses[1].classAthletes[currentClassHour].length} / ${selectedClasses[1].maxAthletes} Participants',
                          style: TextStyle(color: kTextColor),
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
    // if (mainScreenModel.classes != null) {
    //   return Expanded(
    //     child: ListView.builder(
    //         itemCount: selectedClasses[1].startingHours.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           final String currentClassHour = classHours[index];
    //           return InkWell(
    //             onTap: () => Navigator.pushNamed(
    //                 context, AppRoutes.classDetailsRoute,
    //                 arguments: [selectedClasses[1], index]),
    //             child: DefaultCard(
    //               child: Row(
    //                 children: [
    //                   Column(
    //                     children: [
    //                       Text(
    //                         DateFormat.jm()
    //                             .format(selectedClasses[1].startingHours[index])
    //                             .toString()
    //                             .toLowerCase(),
    //                         style:
    //                         TextStyle(fontSize: 22, color: kWhiteTextColor),
    //                       ),
    //                       Text(DateFormat('E d, MMM')
    //                           .format(selectedClasses[1].classDate)
    //                           .toString()),
    //                     ],
    //                   ),
    //                   Flexible(
    //                     child: ListTile(
    //                       title: Text(
    //                         selectedClasses[1].startingHours[index].hour != 12
    //                             ? 'CrossFit Class'
    //                             : 'Open Box',
    //                         style:
    //                         TextStyle(fontSize: 24, color: kWhiteTextColor),
    //                       ),
    //                       subtitle: Text(
    //                         '${selectedClasses[1].classAthletes[currentClassHour].length} / ${selectedClasses[1].maxAthletes} Participants',
    //                         style: TextStyle(color: kTextColor),
    //                       ),
    //                       trailing: Icon(
    //                         Icons.arrow_forward_ios,
    //                         size: 28,
    //                         color: kButtonColor,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }),
    //   );
    // } else {
    //   return Center(child: Text('WRONG'));
    // }
  }

  Widget displayWodList(List<Wod> allWods, MainScreenModel mainScreenModel) {
    final df = DateFormat('dd/MM/yyyy');
    List<Wod> selectedWods = allWods
        .where(
            (element) => mainScreenModel.selectedDate.day == element.date.day)
        .toList();

    if (mainScreenModel.selectedDate.weekday == 6 ||
        mainScreenModel.selectedDate.weekday == 7) {
      return RestDayMessage();
    } else if (mainScreenModel.selectedDate.isBefore(firstDate)) {
      return Center(child: Text('THIS WOD IS NO LONGER AVAILABLE'));
    } else if (mainScreenModel.selectedDate
        .isAfter(today.add(Duration(days: 1)))) {
      return Center(
        child: Text(
            'THIS WOD CANNOT BE VIEWED UNTIL ${df.format(mainScreenModel.selectedDate)}'),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: selectedWods.length,
          itemBuilder: (BuildContext context, int index) {
            Wod wod = selectedWods[index];
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
                      trailing: PopupWodMenu(currentWod: wod),
                    ),
                  ),
                  DividerSmall(),
                  Text(wod.description, style: TextStyle(fontSize: 20)),
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
