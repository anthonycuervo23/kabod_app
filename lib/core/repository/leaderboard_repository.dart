import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';

class LeaderBoardRepository {
  final FirebaseFirestore _firestore;

  LeaderBoardRepository(this._firestore) : assert(_firestore != null);

  static List<Result> allResultsList = [];

  listOfUsers() async {
    List listOfUsers =
        await _firestore.collection("users").get().then((val) => val.docs);
    for (int i = 0; i < listOfUsers.length; i++) {
      _firestore
          .collection("users")
          .doc(listOfUsers[i].id.toString())
          .collection("results")
          .snapshots()
          .listen(createListOfResults);
    }
  }

  createListOfResults(QuerySnapshot snapshot) async {
    var docs = snapshot.docs;
    for (var Doc in docs) {
      allResultsList.add(Result.fromFireStore(Doc));
    }
  }

  // List<DocumentSnapshot> getAllResults() {
  //   _firestore.collection("users").get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       _firestore
  //           .collection("users")
  //           .doc(result.id)
  //           .collection("results")
  //           .get()
  //           .then((querySnapshot) {
  //         querySnapshot.docs.forEach((result) {
  //           print(result.data());
  //           // return result.data();
  //         });
  //       });
  //     });
  //   });
  // }
}
