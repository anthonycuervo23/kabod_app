import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/auth/screens/login_screens_controller.dart';

class UploadStory {
  videoUplaod(String outputPath, UserRepository userRepository, context) async {
    var rng = new Random();
    String uploadName = '';
    for (int i = 0; i < 20; i++) {
      uploadName += rng.nextInt(100).toString();
    }
    uploadName = uploadName + '.pdf';
    if (outputPath == null) return;
    final userName = userRepository.userModel?.name;
    final destination = 'stories/$userName/$uploadName';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      var uploadResult = await ref.putFile(File(outputPath));
      if (uploadResult.state == TaskState.running) {
        print("upload started");
      } else if (uploadResult.state == TaskState.success) {
        String url = await uploadResult.ref.getDownloadURL();
        DocumentReference reference =
            FirebaseFirestore.instance.collection('Stories').doc('story');

        //fetch data
        final List fetchedStories = reference.get().then((value) {
          return value.data().entries.elementAt(0).value["stories"];
        }) as List;

        final uploadableList = fetchedStories
          ..add({"storyUrl": url, "dateTime": DateTime.now(), "type": "video"});

        reference.set({
          userName: {
            "profileImage": userRepository.userModel?.photoUrl,
            "stories": uploadableList,
          },
        }, SetOptions(merge: true)).whenComplete(() {
          print(url);
          final snackBar = SnackBar(content: Text(' Story Added'));
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => HomePage()));
        });
      } else {
        print("storyuploading error");
      }
    } catch (error) {
      print(error);
    }
  }

  imageUpload(GlobalKey previewContainer, UserRepository userRepository,
      context) async {
    //done: save image and return captured image to previous screen
  }
}
