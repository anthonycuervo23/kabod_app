import 'package:cloud_firestore/cloud_firestore.dart';

//My imports
import 'package:kabod_app/core/model/schedule_model.dart';

class ScheduleRepository {
  final FirebaseFirestore _firestore;

  ScheduleRepository(this._firestore) : assert(_firestore != null);

  Stream<List<Schedule>> getSchedule() {
    return _firestore.collection('schedule').snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (document) => Schedule.fromMap(document.data(), document.id),
          )
          .toList();
    });
  }
}
