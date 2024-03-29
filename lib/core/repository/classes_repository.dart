import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiver/iterables.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<List<UserModel>> getListOfUsers({List<dynamic> listUid}) {
    if (listUid.isNotEmpty) {
      final memberChunks = partition(listUid, 10);
      List<Stream<List<UserModel>>> streams = [];
      memberChunks.forEach((chunk) => streams.add(_firestore
          .collection('users')
          .where('user_id', whereIn: chunk)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map(
                  (document) => UserModel.fromMap(document.id, document.data()))
              .toList())));
      if (streams.length == 1) {
        return ZipStream(streams, (values) => values.first);
      }
      return ZipStream.zip2(streams[0], streams[1], (a, b) => a + b);
    }
    return null;
  }

  Future<List<UserModel>> getUserDetailsById(List ids) async {
    try {
      List<UserModel> users = [];
      for (var id in ids) {
        print(id);
        final DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(id).get();
        users.add(UserModel.fromMap(id, documentSnapshot.data()));
      }
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
