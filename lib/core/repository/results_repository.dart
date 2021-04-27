import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

//My imports
import 'package:kabod_app/screens/results/model/results_model.dart';

class ResultRepository extends ChangeNotifier {
  final FirebaseFirestore _firestore;

  ResultRepository(this._firestore) : assert(_firestore != null);

  Future<void> addResult(Map<String, dynamic> data, String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .add(data)
        .then((value) => data['result_id'] = value.id);
  }

  List<Result> listOfResults = [];
  Future<void> getResult(String uid, String currentWod) async {
    final results = await _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .where('wod_name', isEqualTo: currentWod)
        .get();
    if (results.docs != null && results.docs.isNotEmpty) {
      for (var result in results.docs) {
        Result existingResult = listOfResults.firstWhere(
            (resultToCheck) =>
                resultToCheck.wodName ==
                Result.fromMap(result.data(), result.id).wodName,
            orElse: () => null);
        if (existingResult == null) {
          listOfResults.removeWhere((element) => element.wodName == currentWod);
          listOfResults.add(Result.fromMap(result.data(), result.id));
        }
      }
    } else {
      listOfResults.removeWhere((element) => element.wodName == currentWod);
    }
    notifyListeners();
  }

  Future<void> deleteResult(String uid, String id) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .doc(id)
        .delete();
  }
}
