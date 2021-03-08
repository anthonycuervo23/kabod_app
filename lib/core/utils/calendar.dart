DateTime beginningOfDay(date) =>
    DateTime(date.year, date.month, date.day, 0, 0, 0);

DateTime endOfDay(date) =>
    DateTime(date.year, date.month, date.day, 23, 59, 59);

DateTime lastDayOfMonth(DateTime month) {
  var beginningNextMonth = (month.month < 12)
      ? DateTime(month.year, month.month + 1, 1)
      : DateTime(month.year + 1, 1, 1);
  return beginningNextMonth.subtract(Duration(days: 1));
}
