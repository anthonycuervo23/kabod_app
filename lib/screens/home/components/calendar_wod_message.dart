import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

//my imports
import 'package:kabod_app/core/utils/calendar.dart';
import 'package:kabod_app/screens/commons/dividers.dart';

class RestDayMessage extends StatelessWidget {
  const RestDayMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            child: Image.asset(
              'assets/images/rest_day.jpg',
              fit: BoxFit.cover,
            ),
          ),
          DividerSmall(),
          Text(
            'Today is a very important day as it is your scheduled rest day. We pre-program rest days in order to give your body the time it needs to recover and reap the rewards of all the hard work you\'ve done the last few days.',
            style: TextStyle(fontSize: 18),
          ),
          DividerSmall(),
          Text(
              'If you still plan to exercise then please click on a previous calendar day to select a new workout.',
              style: TextStyle(fontSize: 18)),
          DividerSmall(),
          Text(
              'Note: A rest day does not mean that you still can\'t be active: get outside, go for a hike, play with your kids, let your imagination run wild 😉',
              style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}

class WodNotAvailable extends StatelessWidget {
  const WodNotAvailable({
    Key key,
    @required CalendarController calendarController,
  })  : _calendarController = calendarController,
        super(key: key);

  final CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final firstDate = beginningOfDay(DateTime(today.year, today.month, 1));
    final df = DateFormat('dd/MM/yyyy');
    return Text(_calendarController.selectedDay.isBefore(firstDate)
        ? 'THIS WOD IS NOT AVAILABLE ANYMORE'
        : 'THIS WOD CANNOT BE VIEWED UNTIL ${df.format(_calendarController.selectedDay)}');
  }
}
