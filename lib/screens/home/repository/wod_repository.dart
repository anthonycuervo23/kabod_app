import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';

class WodRepository {
  final FirebaseFirestore _firestore;

  WodRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Wod>> getWods() {
    return _firestore.collection('wods').snapshots().map((snapshot) {
      return snapshot.docs
          .map((document) => Wod.fromFirestore(document))
          .toList();
    });
  }
}
