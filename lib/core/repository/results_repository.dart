import 'package:cloud_firestore/cloud_firestore.dart';

class ResultRepository {
  final FirebaseFirestore _firestore;

  ResultRepository(this._firestore) : assert(_firestore != null);

  Future<void> addResult(Map<String, dynamic> data, String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('results')
        .add(data);
  }
}
