import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/Stories/model/storyModel.dart';
import 'package:kabod_app/screens/Stories/model/userStories.dart';
import 'package:kabod_app/screens/Stories/story_create.dart';
import 'package:kabod_app/screens/Stories/display_story.dart';
import 'package:kabod_app/screens/chat/components/loading.dart';

class MyStories extends StatefulWidget {
  final UserStories userStories;
  final String userId;

  const MyStories({Key key, this.userStories, this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _MyStories(userStories, userStories.stories.reversed.toList(), userId);
}

class _MyStories extends State<MyStories> {
  final UserStories user;
  List<StoryModel> stories;
  final String userId;
  DocumentReference reference;

  bool _isListChanged = false;

  bool _isLoading = false;

  _MyStories(this.user, this.stories, this.userId) {
    reference = FirebaseFirestore.instance.collection('Stories').doc(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My Stories"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _isListChanged),
          ),
          centerTitle: true),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                StoryModel story = stories[index];
                return Container(
                  key: ObjectKey(stories[index]),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: kButtonColor))),
                  child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoryDisplay(
                                      UserStories.getSingleStory(user, story),
                                      userId,
                                      isMine: true)));
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: user.profilePicURL != null
                                ? CachedNetworkImage(
                                    imageUrl: user.profilePicURL,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    kButtonColor)))
                                :Image.asset(
                                    'assets/images/profile_image.jpg'),
                          ),
                        ),
                      ),
                      /*subtitle: Text(
                        getUploadedTime(story.dateTime),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                      ),*/
                      title: Text(
                        story.viewed.length.toString() + " views ( "+getUploadedTime(story.dateTime)+" )",
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(Icons.menu, color: kButtonColor),
                        color: kButtonColor,
                        onSelected: (s) => deleteStory(story),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                                value: "delete",
                                child: Text(
                                  "delete",
                                  textAlign: TextAlign.center,
                                ))
                          ];
                        },
                      )),
                );
              }),
          Visibility(
            visible: _isLoading,
            child: Loading(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StoryCreate();
          }));
        },
        backgroundColor: kButtonColor,
        child: Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  deleteStory(StoryModel story) async {
    setState(() {
      _isLoading = true;
    });

    print("my story " + user.toMap().toString());
    final snackBar = SnackBar(
        content: Text(' Can\'t delete Status\n Something Went Wrong! '));
    String destination = "stories/$userId/" + story.fileName;
    user.stories.remove(story);

    print("delete file" + user.toMap().toString());

    if (user.stories.isEmpty) {
      await reference.delete().then((value) async {
        await _deleteStoryFile(destination, story);
        Navigator.pop(context, _isListChanged);
      }, onError: (e, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
    } else
      await reference.update(user.toMap()).then((value) async {
        await _deleteStoryFile(destination, story);
      }, onError: (e, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });

    setState(() {
      _isLoading = false;
    });
  }

  Future _deleteStoryFile(String destination, StoryModel story) {
    _isListChanged = true;
    setState(() {
      stories.remove(story);
    });
    final fileRef = FirebaseStorage.instance.ref(destination);
    print("delete story file");
    return fileRef.delete();
  }

  String getUploadedTime(DateTime time) {
    Duration duration = DateTime.now().difference(time);
    if (duration.inMinutes == 0)
      return "just now";
    else if (duration.inHours == 0)
      return duration.inMinutes.toString() + " minutes ago";
    else
      return duration.inHours.toString() + " hours ago";
  }
}
