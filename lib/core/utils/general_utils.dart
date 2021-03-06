import 'package:url_launcher/url_launcher.dart';

DateTime beginningOfDay(date) =>
    DateTime(date.year, date.month, date.day, 0, 0, 0);
DateTime endOfDay(date) =>
    DateTime(date.year, date.month, date.day, 23, 59, 59);
DateTime firstDayOfMonth(date) => DateTime(date.year, date.month + 1);

DateTime lastDayOfMonth(DateTime month) {
  var beginningNextMonth = (month.month < 12)
      ? DateTime(month.year, month.month + 1, 1)
      : DateTime(month.year + 1, 1, 1);
  return beginningNextMonth.subtract(Duration(days: 1));
}

List<DateTime> dateTimeFromStrings(List<String> listOfClasses) {
  List<DateTime> listOfHours = [];
  for (int i = 0; i < listOfClasses.length; i++) {
    String key = listOfClasses[i];
    int dateInt = int.parse(key);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInt);
    listOfHours.add(date);
  }
  return listOfHours;
}

String stringFromDuration(Duration initialTimer) {
  Duration duration = initialTimer;
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

Duration durationFromString(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

double doubleFromString(String s) {
  double d = double.parse(s.replaceAll(',', '.'));
  return d;
}

//get the first name and the initial of the middle or last name
//this way the ui wont be affected.
String formatName(String fullName) {
  bool appendLastName = false;

  fullName = fullName.trimRight();

  List<String> tempList = fullName.split(" ");

  int start = 0;
  int end = tempList.length;
  String initial;

  if (end > 1) {
    end = 1;
    initial = tempList[1].substring(0, 1).toUpperCase();
    appendLastName = true;
  }

  final selectedWords = tempList.sublist(start, end);

  String output = selectedWords.join(" ");

  if (appendLastName) {
    output += ' $initial.';
  }

  return output;
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

String formatTime(Duration duration) {
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
