import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import 'model/storyModel.dart';
import 'model/userStories.dart';

class AddStory extends StatefulWidget {
  final Widget child;
  final Future<File> Function() getFile;
  final Function duration;
  final String fileType;
  final bool shareButtonEnable;

  const AddStory(
      {Key key,
      @required this.child,
      this.getFile,
      this.duration,
      this.fileType,
      this.shareButtonEnable = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddStory();
}

class _AddStory extends State<AddStory> {
  bool isLoading = false;
  double fileUploadProgress;

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Story"),
        actions: [
          TextButton(
              onPressed: !widget.shareButtonEnable
                  ? null
                  : () async {
                      File file = await widget.getFile();
                      if (file != null && file.existsSync()) {
                        setState(() {
                          isLoading = true;
                        });
                        uploadFile(file, userRepository?.userModel);
                      }
                    },
               child: Text("Done",style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
      body: Column(
        children: [
          Visibility(
            child: LinearProgressIndicator(
              backgroundColor: Colors.red,
              value: fileUploadProgress,
            ),
            visible: isLoading,
          ),
          Expanded(child: widget.child)
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  uploadFile(File storyFile, UserModel userModel) {
    if (storyFile == null && storyFile.existsSync()) {
      final snackBar = SnackBar(content: Text(' Something Went Wrong! '));
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      Navigator.pop(context);
      return;
    }

    final uploadName = p.basename(storyFile.path);
    final userID = userModel?.id;
    final destination = 'stories/$userID/$uploadName';
    final uploadRef = FirebaseStorage.instance.ref(destination);
    print(destination);
    try {
      UploadTask uploadStatus = uploadRef.putFile(storyFile);
      uploadStatus.snapshotEvents.listen((event) {
        var progress = event.bytesTransferred / event.totalBytes;
        setState(() {
          fileUploadProgress = progress > 0 ? progress : null;
        });
        print(fileUploadProgress);
      });
      uploadStatus.then((data) async {
        storyFile.delete();
        print("uploading successful" + data.state.toString());
        //get time
        String url = await data.ref.getDownloadURL();
        print(url);
        var date = data.metadata.updated;
        StoryModel story = new StoryModel(
            fileType: widget.fileType,
            fileURL: url,
            dateTime: date,
            duration: widget.duration(),
            fileName: uploadName);

        if (!await _uploadStoryEntry(story, userModel)) {
          await uploadRef.delete();
          final snackBar = SnackBar(content: Text(' Something Went Wrong! '));
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
      }, onError: (e) {
        final snackBar = SnackBar(content: Text(' Something Went Wrong! '));
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
    } catch (error) {
      print(error);
    }
  }

  Future<bool> _uploadStoryEntry(StoryModel story, UserModel user) async {
    bool isSuccess = false;
    DocumentReference storiesRef =
        FirebaseFirestore.instance.collection('Stories').doc(user.id);
    //fetch data first
    await storiesRef.get().then((value) async {
      List stories = value.exists ? (value.get('stories') as List) : [];
      stories.add(story.toMap());
      print("story size " + stories.length.toString());

      await storiesRef
          .set(
              new UserStories(
                      userID: user.id,
                      userName: user.name,
                      profilePicURL: user.photoUrl,
                      dateTime: story.dateTime)
                  .toMap(stories: stories),
              SetOptions(merge: true))
          .then((value) {
        setState(() {
          isLoading = false;
          fileUploadProgress = null;
        });

        final snackBar = SnackBar(content: Text(' Story Added'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).popUntil((route) => route.isFirst);
        isSuccess = true;
      }, onError: (e, s) => isSuccess = false);
    }, onError: (e, s) => isSuccess = false);

    return isSuccess;
  }
}
