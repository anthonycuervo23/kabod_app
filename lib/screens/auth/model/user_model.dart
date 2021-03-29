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
    introSeen = data['intro_seen'];
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
    data['intro_seen'] = introSeen;
    return data;
  }
}
