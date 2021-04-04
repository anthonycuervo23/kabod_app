class Result {
  String time;
  String reps;
  String rounds;
  DateTime date;
  String id;
  String weight;
  String customScore;
  bool rx;
  String comment;
  String photoUrl;
  String wodId;

  Result(
      {this.time,
      this.reps,
      this.rounds,
      this.date,
      this.id,
      this.photoUrl,
      this.wodId,
      this.weight,
      this.comment,
      this.customScore,
      this.rx});

  Result.fromMap(Map<String, dynamic> data, String id)
      : time = data['time'],
        reps = data['reps'],
        rounds = data['rounds'],
        photoUrl = data['result_photo'],
        wodId = data['wod_id'],
        weight = data['weight'],
        comment = data['comment'],
        customScore = data['custom_score'],
        rx = data['rx'],
        date = DateTime.fromMillisecondsSinceEpoch(data['result_date']),
        id = id;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wod_id'] = wodId;
    data['time'] = time;
    data['reps'] = reps;
    data['rounds'] = rounds;
    data['result_photo'] = photoUrl;
    data['weight'] = weight;
    data['comment'] = comment;
    data['custom_score'] = customScore;
    data['rx'] = rx;
    data['result_date'] = date;
    return data;
  }
}
