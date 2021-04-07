import 'package:cloud_firestore/cloud_firestore.dart';

class ResultRepository {
  final FirebaseFirestore _firestore;

  ResultRepository(this._firestore) : assert(_firestore != null);

  Future<void> addResult(Map<String, dynamic> data) {
    return _firestore.collection('results').add(data);
  }
}
