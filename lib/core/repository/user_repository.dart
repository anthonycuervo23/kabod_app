import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

//My imports
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/chat/helpers/sharedPreferences_helper.dart';
import 'package:kabod_app/service/sharedPreferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository extends ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  User _user;
  Status _status = Status.Uninitialized;
  String _error;
  StreamSubscription _userListener;
  UserModel _fsUser;
  bool _loading;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Status get status => _status;

  User get user => _user;

  String get error => _error;

  UserModel get userModel => _fsUser;

  bool get isLoading => _loading;

  UserRepository.instance() : _firebaseAuth = FirebaseAuth.instance {
    _loading = true;
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    SharedPrefs.sharedPrefs.clear();
    _firebaseAuth.signOut();
    _status = Status.Unauthenticated;
    _fsUser = null;
    _userListener.cancel();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      _error = e.message;
      return false;
    }
  }

  Future<void> updateData(String id, Map<String, dynamic> data) async {
    // final userDB =
    return await _db.collection('users').doc(id).update(data);
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      _fsUser = null;
      _user = null;
    } else {
      _user = firebaseUser;
      _saveUserRecord();
      //_nameSaver();
      final userDB = _db.collection('users').doc(_user.uid);
      _userListener = userDB
          .snapshots()
          .map((snap) =>
              snap.exists ? UserModel.fromMap(snap.id, snap.data()) : null)
          .listen((user) {
        _fsUser = user;
        _loading = false;
        notifyListeners();
      });
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> _saveUserRecord() async {
    if (_user == null) return;
    UserModel user = UserModel(
      email: _user.email,
      name: _user.displayName,
      admin: false,
      photoUrl: _user.photoURL,
      id: _user.uid,
      registrationDate: DateTime.now().toUtc(),
      lastLoggedIn: DateTime.now().toUtc(),
      introSeen: false,
    );
    //SharedPrefs.sharedPrefs.setString('userName', _user.displayName);
    SharedPreferenceHelper().saveUserEmail(_user.email);
    SharedPreferenceHelper().saveUserId(_user.uid);
    final userDB = _db.collection('users').doc(_user.uid);
    if ((await userDB.get()).exists) {
      await userDB.update({
        'last_logged_in': FieldValue.serverTimestamp(),
      });
    } else {
      await userDB.set(user.toMap());
    }
  }

  @override
  void dispose() {
    _userListener.cancel();
    super.dispose();
  }
}
