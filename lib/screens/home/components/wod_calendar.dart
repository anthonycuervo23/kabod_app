import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

//my imports
import 'package:kabod_app/core/model/calendar_modifier.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class WodCalendar extends StatefulWidget {
  const WodCalendar({
    Key key,
    @required CalendarController calendarController,
  })  : _calendarController = calendarController,
        super(key: key);

  final CalendarController _calendarController;

  @override
  _WodCalendarState createState() => _WodCalendarState();
}

class _WodCalendarState extends State<WodCalendar> {
  CalendarModifier calendarModifierProvider;

  @override
  Widget build(BuildContext context) {
    calendarModifierProvider = Provider.of<CalendarModifier>(context);
    return TableCalendar(
      events: calendarModifierProvider.wods,
      onDaySelected: (day, wods, _) {
        calendarModifierProvider.whenSelectedDay(wod: wods);
      },
      calendarController: widget._calendarController,
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
