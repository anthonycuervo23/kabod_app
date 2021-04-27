import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

//My imports
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';

class ApiService {
  // Fetch the currentUser, and then get its id token
  final User user = FirebaseAuth.instance.currentUser;

  final String apiUrl = "http://10.0.2.2:8080/exercises";

  // Fetch the list of Exercises
  Future<List<Exercise>> getExercises() async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {"authorization": 'Bearer $token'};

    Response res = await get(Uri.parse(apiUrl), headers: header);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Exercise> exercises =
          body.map((dynamic item) => Exercise.fromJson(item)).toList();
      return exercises;
    } else {
      throw "Failed to load Exercise list";
    }
  }

  // Fetch Exercise by id
  Future<Exercise> getExerciseById(String id) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {"authorization": 'Bearer $token'};

    final response = await get(Uri.parse('$apiUrl/$id'), headers: header);

    if (response.statusCode == 200) {
      return Exercise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a Exercise');
    }
  }

  // Create a new Exercise
  Future<Exercise> createExercise(Exercise exercise) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {
      "authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    Map data = {
      'exercise': exercise.exercise,
      'uid': exercise.uid,
    };

    final Response response = await post(
      Uri.parse('$apiUrl/create'),
      headers: header,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Exercise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post a Exercise');
    }
  }

  // Update an Exercise with id
  Future<Exercise> updateExercise(String id, Exercise exercise) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {
      "authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    Map data = {
      'exercise': exercise.exercise,
      'uid': exercise.uid,
    };

    final Response response = await put(
      Uri.parse('$apiUrl/$id'),
      headers: header,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Exercise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a Exercise');
    }
  }

  // Delete an Exercise with id
  Future<void> deleteExercise(String id) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {"authorization": 'Bearer $token'};

    Response res = await delete(Uri.parse('$apiUrl/$id'), headers: header);

    if (res.statusCode == 200) {
      print("Exercise deleted");
    } else {
      throw "Failed to delete a Exercise.";
    }
  }

  // Fetch all Results that belong to a Exercise id
  Future<List<Result>> getResults(String id) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {"authorization": 'Bearer $token'};

    Response res =
        await get(Uri.parse('$apiUrl/$id/results/'), headers: header);

    if (res.statusCode == 200) {
      print('$apiUrl/$id/results/');
      List<dynamic> body = jsonDecode(res.body);
      List<Result> results =
          body.map((dynamic item) => Result.fromJson(item)).toList();
      return results;
    } else {
      throw "Failed to load Result list";
    }
  }

  // Create a new Result in specific Exercise id
  Future<Result> createResult(Result result, String id) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {
      "authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    Map data = {
      'weight': result.weight,
      'reps': result.reps,
      'time': result.time,
      'score_type': result.scoreType,
      'createdAt': result.createdAt,
    };

    final Response response = await post(
      Uri.parse('$apiUrl/$id/results/create'),
      headers: header,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post a Result');
    }
  }

  // Update a Result with id
  Future<Result> updateResult(String id, Result result) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {
      "authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    Map data = {
      'weight': result.weight,
      'reps': result.reps,
      'time': result.time,
      'score_type': result.scoreType,
      'createdAt': result.createdAt,
    };

    final Response response = await put(
      Uri.parse('$apiUrl/$id'),
      headers: header,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a Result');
    }
  }

  // Delete a Result with id
  Future<void> deleteResult(String id) async {
    final IdTokenResult idToken = await user.getIdTokenResult();
    String token = idToken.token;

    // Create authorization header
    final header = {"authorization": 'Bearer $token'};

    Response res =
        await delete(Uri.parse('$apiUrl/results/$id'), headers: header);

    if (res.statusCode == 200) {
      print("Result deleted");
    } else {
      throw "Failed to delete Result.";
    }
  }
}
