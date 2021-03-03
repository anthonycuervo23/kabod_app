import 'package:cloud_firestore/cloud_firestore.dart';

//my imports
import 'package:kabod_app/screens/home/model/wod_model.dart';

class WodRepository {
  final FirebaseFirestore _firestore;

  WodRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Wod>> getWods() {
    return _firestore.collection('wods').snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (document) => Wod.fromMap(document.data(), document.id),
          )
          .toList();
    });
  }

  Future<void> addWod(Map data) {
    return _firestore.collection('wods').add(data);
  }

  Future<void> deleteWod(String id) {
    return _firestore.collection('wods').doc(id).delete();
  }

  Future<void> updateWod(String id, Map data) {
    return _firestore.collection('wods').doc(id).update(data);
  }
}
