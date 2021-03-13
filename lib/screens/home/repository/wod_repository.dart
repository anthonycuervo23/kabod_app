import 'package:cloud_firestore/cloud_firestore.dart';

//my imports
import 'package:kabod_app/screens/home/model/wod_model.dart';

class WodRepository {
  final FirebaseFirestore _firestore;

  WodRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Wod>> getWods(int firstDate, int lastDate) {
    return _firestore.collection('wods').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc['wod_date'] >= firstDate)
          .where((doc) => doc['wod_date'] <= lastDate)
          .map(
            (document) => Wod.fromMap(document.data(), document.id),
          )
          .toList();
    });
  }

  Future<bool> addWod(Map<String, dynamic> data) async {
    DateTime now = DateTime.now();
    dynamic wodDate = data['wod_date'];
    DateTime convertedTime =
        DateTime.fromMillisecondsSinceEpoch(wodDate, isUtc: true).toLocal();
    if (convertedTime is DateTime) {
      if (convertedTime.day >= now.day &&
          convertedTime.month >= now.month &&
          convertedTime.year >= now.year) {
        await _firestore.collection('wods').add(data);
        return true;
      }
    }
    return false;
  }

  Future<bool> updateWod(String id, Map data) async {
    DateTime now = DateTime.now();
    dynamic wodDate = data['wod_date'];
    DateTime convertedTime =
        DateTime.fromMillisecondsSinceEpoch(wodDate, isUtc: true).toLocal();
    if (convertedTime is DateTime) {
      if (convertedTime.day >= now.day &&
          convertedTime.month >= now.month &&
          convertedTime.year >= now.year) {
        await _firestore.collection('wods').doc(id).update(data);
        return true;
      }
    }
    return false;
  }

  Future<void> deleteWod(String id) {
    return _firestore.collection('wods').doc(id).delete();
  }
}
