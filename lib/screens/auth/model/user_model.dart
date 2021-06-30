import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String phone;
  bool admin;
  String email;
  String gender;
  DateTime lastLoggedIn;
  DateTime registrationDate;
  String photoUrl;
  DateTime birthDate;
  bool introSeen;
  int totalClasses;
  String currentVersion;

  UserModel(
      {this.id,
      this.name,
      this.phone,
      this.admin,
      this.gender,
      this.email,
      this.birthDate,
      this.lastLoggedIn,
      this.registrationDate,
      this.photoUrl,
      this.currentVersion,
      this.totalClasses,
      this.introSeen});

  UserModel.fromMap(String id, Map<String, dynamic> data) {
    id = id;
    name = data['name'];
    admin = data['admin'];
    phone = data['phone'];
    gender = data['gender'];
    birthDate = DateTime.fromMillisecondsSinceEpoch(data['birth_date']);
    email = data['email'];
    lastLoggedIn = data['last_logged_in']?.toDate();
    registrationDate = data['registration_date']?.toDate();
    photoUrl = data['photo_url'];
    currentVersion = data['currentVersion'];
    totalClasses = data['totalClasses'];
    introSeen = data['intro_seen'];
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot['name'];
    admin = snapshot['admin'];
    phone = snapshot['phone'];
    gender = snapshot['gender'];
    birthDate = DateTime.fromMillisecondsSinceEpoch(snapshot['birth_date']);
    email = snapshot['email'];
    lastLoggedIn = snapshot['last_logged_in']?.toDate();
    registrationDate = snapshot['registration_date']?.toDate();
    photoUrl = snapshot['photo_url'];
    currentVersion = snapshot['currentVersion'];
    totalClasses = snapshot['totalClasses'];
    introSeen = snapshot['intro_seen'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = id;
    data['name'] = name;
    data['admin'] = admin;
    data['phone'] = phone;
    data['gender'] = gender;
    data['birth_date'] = 0;
    data['email'] = email;
    data['last_logged_in'] = lastLoggedIn;
    data['registration_date'] = registrationDate;
    data['photo_url'] = photoUrl;
    data['currentVersion'] = currentVersion;
    data['totalClasses'] = totalClasses;
    data['intro_seen'] = introSeen;
    return data;
  }
}
