import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(scaffoldKey: _scaffoldKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addWodRoute),
        child: Icon(
          Icons.add,
          color: kBackgroundColor,
          size: 40,
        ),
      ),
      body: StreamBuilder<List<Wod>>(
          stream: mainScreenModel.wodStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final List<Wod> wods = snapshot.data;
              mainScreenModel.groupWods(wods);
              return Column(
                children: [
                  Material(
                    color: kPrimaryColor,
                    elevation: 0,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: kDefaultPadding, right: kDefaultPadding),
                      height: size.height * 0.3,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome Back, Jean.!',
                            style: TextStyle(fontSize: 16, color: kTextColor),
                          ),
                          DividerBig(),
                          WodCalendar(),
                          DividerSmall(),
                        ],
                      ),
                    ),
                  ),
                  DividerMedium(),
                  Text('Today\'s WOD',
                      style: TextStyle(fontSize: 28, color: kWhiteTextColor)),
                  DividerMedium(),
                  displayWodList(wods, mainScreenModel)
                ],
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
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
