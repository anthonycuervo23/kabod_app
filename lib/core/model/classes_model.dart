class Classes {
  String id;
  DateTime classDate;
  int maxAthletes;
  List<dynamic> startingHours;
  Map<String, List<dynamic>> classAthletes;

  Classes(
      {this.id,
      this.classDate,
      this.maxAthletes,
      this.startingHours,
      this.classAthletes});

  Classes.fromMap(Map<String, dynamic> data, String id) {
    this.id = id;
    classDate = DateTime.fromMillisecondsSinceEpoch(data['class_date']);
    maxAthletes = data['max_athletes'];
    startingHours = convertedDateTime(data);
    classAthletes = Map<String, List<dynamic>>.from(data['class_athletes']);
  }

  convertedDateTime(Map<String, dynamic> data) {
    List<dynamic> currentList = data['class_starting_hours'];
    List<DateTime> newList = [];
    for (int i = 0; i < currentList.length; i++) {
      DateTime hour = DateTime.fromMillisecondsSinceEpoch(currentList[i]);
      newList.add(hour);
    }
    return newList;
  }
}
