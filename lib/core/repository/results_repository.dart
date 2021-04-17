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

  ResultsOfaDay selectedResult = ResultsOfaDay();
  Future<void> getResult(String uid, String currentWod) async {
    final results = await _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .where('wod_name', isEqualTo: currentWod)
        .get();
    if (results.docs != null && results.docs.isNotEmpty) {
      for (var result in results.docs) {
        selectedResult.selectedResult =
            Result.fromMap(result.data(), result.id);
        selectedResult.selectedWod = currentWod;
      }
    } else {
      selectedResult = ResultsOfaDay();
    }
    notifyListeners();
  }

  // Result getTheResult() {
  //   return selectedResult;
  // }

  Future<void> deleteResult(String uid, String id) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .doc(id)
        .delete();
  }
}
