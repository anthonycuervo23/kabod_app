import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// my imports
import 'package:kabod_app/core/presentation/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/icons/drawer_icon.png'),
          onPressed: () {
            _key.currentState.openDrawer();
          },
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 20, top: 15, left: 8, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset('assets/images/profile_image.jpg'),
              ),
            ),
          ),
        ],
      ),
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
                  SizedBox(height: 18),
                  // Text(
                  //   'Calendar',
                  //   style: TextStyle(fontSize: 26),
                  // ),
                  TableCalendar(
                    calendarController: _calendarController,
                    headerVisible: true,
                    headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(fontSize: 26),
                        titleTextBuilder: (date, locale) =>
                            DateFormat.MMMM(locale).format(date),
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false),
                    initialCalendarFormat: CalendarFormat.week,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    calendarStyle: CalendarStyle(
                      contentPadding: EdgeInsets.only(top: 20),
                      weekdayStyle: TextStyle(fontSize: 26),
                      weekendStyle: TextStyle(fontSize: 26),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: kBackgroundColor),
                      weekdayStyle: TextStyle(color: kBackgroundColor),
                    ),
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          date.day.toString(),
                          style:
                              TextStyle(fontSize: 26, color: kWhiteTextColor),
                        ),
                      ),
                      todayDayBuilder: (context, date, events) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kBackgroundColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Today\'s WOD',
                    style: TextStyle(fontSize: 26, color: kWhiteTextColor),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: Card(
                      elevation: 3,
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all((Radius.circular(10)))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding, right: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              child: ListTile(
                                title: Text('Strength',
                                    style: TextStyle(fontSize: 24)),
                                subtitle: Text('For Weight',
                                    style: TextStyle(fontSize: 18)),
                                trailing: PopupMenuButton(
                                  color: kBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          (Radius.circular(10)))),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/results_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Add Score'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          Divider(),
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/timer_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Start Timer'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          Divider(),
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/edit_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Edit WOD'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  child: Icon(
                                    Icons.add_box,
                                    size: 40,
                                    color: kButtonColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '''
Every 2 Minutes For 12 Minutes (6 Sets)

1 Power Snatch + 1 Hang Power Snatch

70-75% Of 1rm Snatch
''',
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: Card(
                      elevation: 3,
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all((Radius.circular(10)))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding, right: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              child: ListTile(
                                title: Text('Murph',
                                    style: TextStyle(fontSize: 24)),
                                subtitle: Text('For Time',
                                    style: TextStyle(fontSize: 18)),
                                trailing: PopupMenuButton(
                                  color: kBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          (Radius.circular(10)))),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/results_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Add Score'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          Divider(),
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/timer_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Start Timer'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                          Divider(),
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/edit_icon.png'),
                                                  SizedBox(width: 10),
                                                  Text('Edit WOD'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  child: Icon(
                                    Icons.add_box,
                                    size: 40,
                                    color: kButtonColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '''
1 Mile Run
100 Pull ups
200 Push ups
300 Squats
1 Mile Run

Partion the Pull ups, Push ups and Squats as needed.
Start and finish with a mile run.
If you have got a twenty pound vest or body armor, wear it.

In memory of Michael Murph, who was killed in Afghanistan June 28th, 2005.''',
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
