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
  }) : super(key: key);

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
      calendarController: calendarModifierProvider.calendarController,
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
