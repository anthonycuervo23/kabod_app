import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

//my imports
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class WodCalendar extends StatefulWidget {
  const WodCalendar({
    Key key,
  }) : super(key: key);

  @override
  _WodCalendarState createState() => _WodCalendarState();
}

class _WodCalendarState extends State<WodCalendar> {
  CalendarController _calendarController;
  MainScreenModel mainScreenModel;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainScreenModel = Provider.of<MainScreenModel>(context);
    return TableCalendar(
      events: mainScreenModel.wods,
      onDaySelected: (day, wods, _) {
        mainScreenModel.whenSelectedDay(day, wods);
      },
      calendarController: _calendarController,
      headerVisible: true,
      headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(fontSize: 26, color: kWhiteTextColor),
          titleTextBuilder: (date, locale) =>
              DateFormat.MMMM(locale).format(date),
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false),
      initialCalendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        markersMaxAmount: 1,
        markersColor: kButtonColor,
        eventDayStyle: TextStyle(fontSize: 26, color: kWhiteTextColor),
        contentPadding: EdgeInsets.only(top: 20),
        weekdayStyle: TextStyle(fontSize: 26, color: kWhiteTextColor),
        weekendStyle: TextStyle(fontSize: 26, color: kWhiteTextColor),
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
            style: TextStyle(fontSize: 26, color: kWhiteTextColor),
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
    );
  }
}
