import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//My imports
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';

class ClassesRepository {
  final FirebaseFirestore _firestore;

  ClassesRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Classes>> getClassesOfTheDay(
      int firstDayOfWeek, int lastDayOfWeek) {
    return _firestore.collection('classes').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc['class_date'] >= firstDayOfWeek)
          .where((doc) => doc['class_date'] <= lastDayOfWeek)
          .map(
            (document) => Classes.fromMap(document.data(), document.id),
          )
          .toList();
    });
  }

  Future<void> addUserToClass(String id, Map data) async {
    return await _firestore
        .collection('classes')
        .doc(id)
        .set(data, SetOptions(merge: true));
  }

  Future<void> removeUserFromClass(String id, Map data) async {
    return await _firestore.collection('classes').doc(id).update(data);
  }

  Stream<List<UserModel>> getListOfUsers({@required List<dynamic> listUid}) {
    var ref = _firestore.collection('users');
    if (listUid.isNotEmpty)
      return ref
          .where('user_id', whereIn: listUid)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.docs
            .map(
              (document) => UserModel.fromMap(document.id, document.data()),
            )
            .toList();
      });
  }
}
