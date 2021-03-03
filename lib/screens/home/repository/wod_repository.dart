import 'package:cloud_firestore/cloud_firestore.dart';

//my imports
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

  Future<bool> addWods(Map<String, dynamic> data) async {
    DateTime now = DateTime.now();
    dynamic wodDate = data['wod_date'];
    if (wodDate is DateTime) {
      DateTime oldDate = wodDate.toLocal();
      if (oldDate.day >= now.day &&
          oldDate.month >= now.month &&
          oldDate.year >= now.year) {
        await _firestore.collection('wods').add(data);
        return true;
      }
    }
    return false;
  }
}
