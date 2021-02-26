import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// my imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/home/components/wod_calendar.dart';
import 'package:kabod_app/screens/home/components/popup_menu.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(scaffoldKey: _scaffoldKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Material(
            color: kPrimaryColor,
            elevation: 3,
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
                    style: TextStyle(fontSize: 16, color: kBackgroundColor),
                  ),
                  DividerBig(),
                  // Text(
                  //   'Calendar',
                  //   style: TextStyle(fontSize: 26),
                  // ),
                  WodCalendar(calendarController: _calendarController),
                  DividerSmall(),
                ],
              ),
            ),
          ),
          DividerMedium(),
          Text('Today\'s WOD',
              style: TextStyle(fontSize: 28, color: kWhiteTextColor)),
          DividerMedium(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: wodList.length,
              itemBuilder: (context, int index) {
                return DefaultCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileTheme(
                        contentPadding: EdgeInsets.all(0),
                        child: ListTile(
                          title: Text(wodList[index].title,
                              style: TextStyle(fontSize: 24)),
                          subtitle: Text(wodList[index].type,
                              style: TextStyle(fontSize: 18)),
                          trailing: PopupWodMenu(),
                        ),
                      ),
                      DividerSmall(),
                      Text(wodList[index].description),
                      DividerSmall(),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return DividerSmall();
              },
            ),
          ),
        ],
      ),
    );
  }
}
