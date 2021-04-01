DateTime beginningOfDay(date) =>
    DateTime(date.year, date.month, date.day, 0, 0, 0);

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

String formatTime(Duration initialTimer) {
  Duration duration = initialTimer;
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

Duration parseDuration(String s) {
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
