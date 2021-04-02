class Wod {
  String title;
  String type;
  String description;
  DateTime date;
  String id;

  Wod({this.title, this.type, this.description, this.date, this.id});

  Wod.fromMap(Map<String, dynamic> data, String id)
      : title = data['wod_name'],
        type = data['wod_type'],
        description = data['wod_description'],
        date = DateTime.fromMillisecondsSinceEpoch(data['wod_date']),
        id = id;
}
