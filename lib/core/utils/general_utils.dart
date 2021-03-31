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
