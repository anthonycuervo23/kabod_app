import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// my imports
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/screens/home/repository/wod_repository.dart';
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
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<List<Wod>> _wodsStream;
  Map<DateTime, List<Wod>> _data;

  @override
  void initState() {
    super.initState();
    _wodsStream = context.read<WodRepository>().getWods();
  }

  _groupWods(List<Wod> wods) {
    _data = {};
    wods.forEach((wod) {
      DateTime date =
          DateTime.utc(wod.date.year, wod.date.month, wod.date.day, 12);
      if (_data[date] == null) _data[date] = [];
      _data[date].add(wod);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(scaffoldKey: _scaffoldKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addWodRoute,
            arguments: _calendarController.selectedDay),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Wod>>(
          stream: _wodsStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final List<Wod> wods = snapshot.data;
              _groupWods(wods);
              DateTime selectedDate = _calendarController.selectedDay;
              List<Wod> _selectedWod = _data[selectedDate] ?? [];
              void _onDaySelected(DateTime day, List wods, List holidays) {
                setState(() {
                  _selectedWod = wods;
                });
              }

              return Column(
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
                            style: TextStyle(
                                fontSize: 16, color: kBackgroundColor),
                          ),
                          DividerBig(),
                          WodCalendar(
                              calendarController: _calendarController,
                              data: _data,
                              selectedDay: _onDaySelected),
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: _selectedWod.length,
                      itemBuilder: (BuildContext context, int index) {
                        Wod wod = _selectedWod[index];
                        return DefaultCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTileTheme(
                                contentPadding: EdgeInsets.all(0),
                                child: ListTile(
                                  title: Text(wod.title,
                                      style: TextStyle(fontSize: 24)),
                                  subtitle: Text(wod.type,
                                      style: TextStyle(fontSize: 18)),
                                  trailing: PopupWodMenu(currentWod: wod),
                                ),
                              ),
                              DividerSmall(),
                              Text(wod.description),
                              DividerSmall(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
}
