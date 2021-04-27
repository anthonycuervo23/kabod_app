class Exercise {
  String id;
  String uid;
  String exercise;
  // Result results;

  Exercise({
    this.id,
    this.uid,
    this.exercise,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["_id"],
      uid: json["uid"],
      exercise: json["exercise"],
    );
  }
}

class Result {
  String id;
  String weight;
  String reps;
  String time;
  String scoreType;
  DateTime createdAt;

  Result(
      {this.id,
      this.weight,
      this.reps,
      this.time,
      this.scoreType,
      this.createdAt});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["_id"],
      weight: json["weight"],
      reps: json["reps"],
      time: json["time"],
      scoreType: json["score_type"],
      createdAt: json["createdAt"].toDate(),
    );
  }
}
