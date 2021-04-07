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

  Result.fromMap(Map<String, dynamic> data, String id)
      : time = data['time'],
        reps = data['reps'],
        rounds = data['rounds'],
        photoUrl = data['result_photo'],
        wodName = data['wod_name'],
        userName = data['user_name'],
        userPhoto = data['user_photo'],
        weight = data['weight'],
        comment = data['result_comment'],
        userId = data['user_id'],
        gender = data['gender'],
        customScore = data['custom_score'],
        rx = data['rx'],
        date = DateTime.fromMillisecondsSinceEpoch(data['result_date']),
        id = id;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wod_name'] = wodName;
    data['user_id'] = userId;
    data['time'] = time;
    data['reps'] = reps;
    data['user_name'] = userName;
    data['user_photo'] = userPhoto;
    data['rounds'] = rounds;
    data['result_photo'] = photoUrl;
    data['weight'] = weight;
    data['result_comment'] = comment;
    data['gender'] = gender;
    data['custom_score'] = customScore;
    data['rx'] = rx;
    data['result_date'] = date;
    return data;
  }
}
