import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class IntroRepository extends ChangeNotifier {
  final FirebaseFirestore _firestore;

  final FirebaseStorage _storage;

  IntroRepository(this._firestore, this._storage) : assert(_firestore != null);

  finishIntroScreen(BuildContext context, String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'intro_seen': true,
    });
    notifyListeners();
  }

  Future<dynamic> uploadFile(String path, File file) async {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    await uploadTask;
    return ref.getDownloadURL();
  }

  Future<void> addProfileInfo(Map<String, dynamic> data, String id) async {
    await _firestore.collection('users').doc(id).update(data);
  }
}
