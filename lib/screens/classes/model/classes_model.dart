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
    classAthletes = Map<String, List<dynamic>>.from(data['class_athletes']);
  }
}
