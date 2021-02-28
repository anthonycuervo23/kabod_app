import 'package:cloud_firestore/cloud_firestore.dart';

class Wod {
  String title;
  String type;
  String description;
  DateTime date;

  Wod({this.title, this.type, this.description, this.date});

  factory Wod.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Wod(
        title: data["wod_name"],
        type: data["wod_type"],
        description: data["wod_description"],
        date: data["wod_date"].toDate());
  }
}
