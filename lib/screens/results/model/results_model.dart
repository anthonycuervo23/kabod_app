import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  String time;
  int reps;
  int rounds;
  DateTime date;
  String id;
  String weight;
  String customScore;
  bool rx;
  String comment;
  String photoUrl;
  String userId;
  String wodName;
  String gender;
  String userName;
  String userPhoto;

  Result(
      {this.time,
      this.reps,
      this.rounds,
      this.date,
      this.id,
      this.photoUrl,
      this.userId,
      this.wodName,
      this.weight,
      this.comment,
      this.gender,
      this.customScore,
      this.userName,
      this.userPhoto,
      this.rx});

  factory Result.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Result(
      id: doc.id,
      time: data['time'],
      reps: data['reps'],
      rounds: data['rounds'],
      date: DateTime.fromMillisecondsSinceEpoch(data['result_date']),
      photoUrl: data['result_photo'],
      wodName: data['wod_name'],
      weight: data['weight'],
      comment: data['comment'],
      customScore: data['custom_score'],
      rx: data['rx'],
      userPhoto: data['user_photo'],
      userName: data['user_name'],
      userId: data['user_id'],
      gender: data['gender'],
    );
  }
}
