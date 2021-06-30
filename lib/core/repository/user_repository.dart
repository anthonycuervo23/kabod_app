import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

//My imports
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/chat/helpers/sharedPreferences_helper.dart';
import 'package:kabod_app/service/sharedPreferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kabod_app/screens/auth/model/device_model.dart';
import 'package:kabod_app/core/repository/user_db_service.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository extends ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  User _user;
  Status _status = Status.Uninitialized;
  String _error;
  StreamSubscription _userListener;
  UserModel _fsUser;
  Device currentDevice;
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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    String version = packageInfo.version;
    UserModel user = UserModel(
      email: _user.email,
      name: _user.displayName,
      admin: false,
      photoUrl: _user.photoURL,
      id: _user.uid,
      currentVersion: "$version+$buildNumber",
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
        'currentVersion': "$version+$buildNumber",
      });
    } else {
      await userDB.set(user.toMap());
    }
    _saveDevice(user);
  }

  Future<void> _saveDevice(UserModel user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    DeviceDetails deviceDescription;
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceDescription = DeviceDetails(
        device: deviceInfo.device,
        model: deviceInfo.model,
        osVersion: deviceInfo.version.sdkInt.toString(),
        platform: 'android',
      );
    }
    if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceDescription = DeviceDetails(
        osVersion: deviceInfo.systemVersion,
        device: deviceInfo.name,
        model: deviceInfo.utsname.machine,
        platform: 'ios',
      );
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    String version = packageInfo.version;
    String currentVersion = "$version+$buildNumber";
    final nowMS = DateTime.now().toUtc().millisecondsSinceEpoch;
    final userDB = _db.collection('users').doc(_user.uid);
    if (user.currentVersion != currentVersion) {
      await userDB.update({
        'last_logged_in': FieldValue.serverTimestamp(),
        'currentVersion': "$version+$buildNumber",
      });
    }
    userDeviceDBS.collection = "users/${user.id}/devices";
    Device existing = await userDeviceDBS.getSingle(deviceId);
    if (existing != null) {
      await userDeviceDBS.updateData(deviceId, {
        'last_updated_at': nowMS,
        'expired': false,
        'uninstalled': false,
      });
      currentDevice = existing;
    } else {
      Device device = Device(
        createdAt: DateTime.now().toUtc(),
        deviceInfo: deviceDescription,
        expired: false,
        id: deviceId,
        lastUpdatedAt: nowMS,
        uninstalled: false,
      );
      await userDeviceDBS.create(device.toMap(), id: deviceId);
      currentDevice = device;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _userListener.cancel();
    super.dispose();
  }
}
