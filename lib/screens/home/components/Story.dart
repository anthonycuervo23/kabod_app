import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/Stories/story_viewer.dart';
import 'package:kabod_app/screens/Stories/model/userStories.dart';
import 'package:kabod_app/screens/Stories/my_story.dart';
import 'package:kabod_app/screens/Stories/story_create.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Story extends StatefulWidget {
  final String userId;

  const Story({Key key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Story();
}

class _Story extends State<Story> {
  final Query storiesQuery = FirebaseFirestore.instance
      .collection('Stories')
      .where('date',
          isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch -
                  Duration.millisecondsPerDay))
      .orderBy('date', descending: true);
  UserStories myStories;
  List<UserStories> userStories = [];

  Stream<Iterable<UserStories>> _loadUserStories(
      String userId, Stream<QuerySnapshot> snapshot) {
    myStories = null;
    return snapshot?.map((event) => event.docs.where((element) {
          if (element.id == userId) {
            if ((element.data()['stories'] as List).isNotEmpty) {
              myStories = UserStories.fromMap(element.data());
            }
            return false;
          }
          return (element['stories'] as List).isNotEmpty;
        }).map((e) => UserStories.fromMap(e.data())));
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);
    final userId = userRepository?.userModel?.id;

    return StreamBuilder<Iterable<UserStories>>(
        stream: _loadUserStories(userId, storiesQuery.snapshots()),
        builder: (context, AsyncSnapshot<Iterable<UserStories>> snapshot) {
          if (snapshot.hasData) userStories = snapshot.data.toList();
          print("Stories " + myStories?.toMap().toString());
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () async {
                    if (await Permission.camera.isGranted || await Permission.camera.request().isGranted){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => myStories == null ||
                                      myStories.stories.length == 0
                                  ? StoryCreate()
                                  : MyStories(
                                      userStories: myStories,
                                      userId: userId))).then((value) {
                        if (value == null || value == true) setState(() {});
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 10),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  width: 2,
                                  color: (myStories == null ||
                                          myStories.stories.length == 0)
                                      ? Colors.transparent
                                      : kButtonColor)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: userRepository.userModel?.photoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: userRepository.userModel.photoUrl,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    kButtonColor)))
                                : Image.asset(
                                    'assets/images/profile_image.jpg'),
                          ),
                        ),
                        if (myStories == null || myStories.stories.length == 0)
                          ClipOval(
                            child: Container(
                              color: Colors.blue,
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: userStories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final user = userStories[index];
                    bool isNewStoryAvail = !user
                        .stories[user.stories.length - 1].viewed
                        .contains(userId);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => StoryViewer(
                                    userStories: userStories,
                                    initialPage: index)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  width: 2,
                                  color: isNewStoryAvail
                                      ? kButtonColor
                                      : Colors.transparent)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: userStories[index].profilePicURL != null
                                ? CachedNetworkImage(
                                    imageUrl: userStories[index].profilePicURL,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    kButtonColor)))
                                : Image.asset(
                                    'assets/images/profile_image.jpg'),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
