import 'package:cloud_firestore/cloud_firestore.dart';

//My imports
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
}
