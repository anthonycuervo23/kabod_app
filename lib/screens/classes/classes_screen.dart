import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/classes/repository/classes_repository.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// my imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<List<Classes>> _classesStream;

  @override
  void initState() {
    super.initState();
    _classesStream = context.read<ClassesRepository>().getClassesOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: Text('Class Schedule'),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TableCalendar(
                    calendarController: _calendarController,
                    headerVisible: true,
                    headerStyle: HeaderStyle(
                        titleTextStyle:
                            TextStyle(fontSize: 26, color: kWhiteTextColor),
                        titleTextBuilder: (date, locale) =>
                            DateFormat.MMMM(locale).format(date),
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false),
                    initialCalendarFormat: CalendarFormat.week,
                    availableGestures: AvailableGestures.none,
                    calendarStyle: CalendarStyle(
                      markersMaxAmount: 1,
                      markersColor: kButtonColor,
                      eventDayStyle:
                          TextStyle(fontSize: 26, color: kWhiteTextColor),
                      contentPadding: EdgeInsets.only(top: 20),
                      weekdayStyle:
                          TextStyle(fontSize: 26, color: kWhiteTextColor),
                      weekendStyle:
                          TextStyle(fontSize: 26, color: kWhiteTextColor),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: kTextColor),
                      weekdayStyle: TextStyle(color: kTextColor),
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
                  DividerSmall(),
                ],
              ),
            ),
          ),
          DividerMedium(),
          Expanded(
            child: StreamBuilder<List<Classes>>(
              stream: _classesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    final List<Classes> currentClass = snapshot.data;
                    final List<String> classHours =
                        currentClass[0].classAthletes.keys.toList();
                    return Expanded(
                      child: ListView.separated(
                        itemCount: currentClass[1].startingHours.length,
                        itemBuilder: (context, index) {
                          final String currentClassHour = classHours[index];
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.classDetailsRoute,
                                arguments: [currentClass[1], index]),
                            child: DefaultCard(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        DateFormat.jm()
                                            .format(currentClass[1]
                                                .startingHours[index])
                                            .toString()
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: kWhiteTextColor),
                                      ),
                                      Text(DateFormat('E d, MMM')
                                          .format(currentClass[1].classDate)
                                          .toString()),
                                    ],
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Text(
                                        currentClass[1]
                                                    .startingHours[index]
                                                    .hour !=
                                                12
                                            ? 'CrossFit Class'
                                            : 'Open Box',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: kWhiteTextColor),
                                      ),
                                      subtitle: Text(
                                        '${currentClass[1].classAthletes[currentClassHour].length} / ${currentClass[1].maxAthletes} Participants',
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
                        },
                        separatorBuilder: (context, index) => DividerMedium(),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
