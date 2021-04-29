class Exercise {
  final String id;
  final String uid;
  final String exercise;
  final List<Result> results;

  Exercise({this.id, this.uid, this.results, this.exercise});

  factory Exercise.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Result> resultsList = list.map((i) => Result.fromJson(i)).toList();

    return Exercise(
        id: parsedJson['id'],
        uid: parsedJson['uid'],
        exercise: parsedJson['exercise'],
        results: resultsList);
  }
}

class Result {
  final String id;
  final int weight;
  final int reps;
  final String time;
  final String comment;
  final String createdAt;

  Result(
      {this.id,
      this.weight,
      this.reps,
      this.time,
      this.comment,
      this.createdAt});

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      id: parsedJson['_id'],
      weight: parsedJson['weight'],
      reps: parsedJson['reps'],
      time: parsedJson['time'],
      comment: parsedJson['comment'],
      //createdAt: DateTime.tryParse(parsedJson['createdAt']),
      createdAt: parsedJson['createdAt'],
    );
  }
}
