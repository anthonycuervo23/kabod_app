class Classes {
  String id;
  DateTime classDate;
  int maxAthletes;
  Map<String, List<dynamic>> classAthletes;

  Classes({this.id, this.classDate, this.maxAthletes, this.classAthletes});

  Classes.fromMap(Map<String, dynamic> data, String id) {
    this.id = id;
    classDate = DateTime.fromMillisecondsSinceEpoch(data['class_date']);
    maxAthletes = data['max_athletes'];
    //classAthletes = mapClassAthletes(data);
    classAthletes = Map<String, List<dynamic>>.from(data['class_athletes']);
  }

  // Map<DateTime, List<String>> mapClassAthletes(Map<String, dynamic> data) {
  //   List keys = data['class_athletes'].keys.toList;
  //   Map<DateTime, List<String>> newClassAndAthletes = {};
  //
  //   for (int i = 0; i < keys.length; i++) {
  //     String key = keys[i];
  //     int dateInt = int.parse(key);
  //     DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInt);
  //     Map<String, List<String>> originalClassAndAthletes = data['class_athletes'];
  //     newClassAndAthletes[date] = originalClassAndAthletes[key];
  //   }
  //   return newClassAndAthletes;
  // }

}
