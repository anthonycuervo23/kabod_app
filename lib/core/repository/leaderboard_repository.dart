import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';

class LeaderBoardRepository {
  final FirebaseFirestore _firestore;

  LeaderBoardRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Result>> getResults(String field, bool order) {
    var ref = _firestore.collection('results');

    return ref.orderBy(field, descending: order).snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (document) => Result.fromMap(document.data(), document.id),
          )
          .toList();
    });
  }
}
