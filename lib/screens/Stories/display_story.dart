import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/chat_repository.dart';
import 'package:kabod_app/core/repository/classes_repository.dart';
import 'package:kabod_app/screens/Stories/model/userStories.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/chat/screens/chat_room.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:provider/provider.dart';

class StoryDisplay extends StatefulWidget {
  final Function() onComplete;
  final UserStories userStories;
  final bool isMine;
  final String userId;

  StoryDisplay(this.userStories, this.userId,
      {this.onComplete, this.isMine = false});

  @override
  State<StatefulWidget> createState() => _StoryDisplay(userStories);
}

class _StoryDisplay extends State<StoryDisplay> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];
  final UserStories user;
  DateTime time;

  CollectionReference query = FirebaseFirestore.instance.collection('Stories');

  int currentStoryIndex = 0;

  bool modalOpen = false;

  _StoryDisplay(this.user);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    user.stories.forEach((e) {
      storyItems.add(e.getStoryItem(controller, widget.userId));
    });
    time = user.stories[0]?.dateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Stack(
          children: [
            StoryView(
              storyItems: storyItems,
              onVerticalSwipeComplete: (d) {
                if (d == Direction.down) Navigator.pop(context);
              },
              controller: controller,
              progressPosition: ProgressPosition.top,
              onComplete: widget.onComplete ??
                  () => !modalOpen ? Navigator.of(context).pop() : null,
              onStoryShow: (story) {
                currentStoryIndex = storyItems.indexOf(story);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    time = user.stories[currentStoryIndex].dateTime;
                  });
                });
                if (user.userID != widget.userId &&
                    !user.stories[currentStoryIndex].viewed
                        .contains(widget.userId)) {
                  user.stories[currentStoryIndex].viewed.add(widget.userId);
                  query.doc(user.userID).update(user.toMap());
                }
              },
            ),
            Positioned(
              top: 40,
              child: Container(
                  width: size.width,
                  child: StoryProfile(user: user, time: time)),
            ),
            if (widget.isMine)
              Positioned(
                bottom: 0,
                left: size.width * 0.44,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBackgroundColor,
                  ),
                  alignment: AlignmentDirectional.center,
                  child: GestureDetector(
                    onTap: () => showViewers(context),
                    child: Text(
                      user.stories[currentStoryIndex].viewed?.length
                              .toString() ??
                          "0",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showViewers(BuildContext context) {
    setState(() {
      modalOpen = true;
    });
    showModalBottomSheet<dynamic>(
      context: context,
      elevation: 0,
      backgroundColor: Colors.grey[900],
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        modalOpen = false;
                      });
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${user.stories[currentStoryIndex].viewed?.length} personas han visto tu historia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder<List<UserModel>>(
                future: Provider.of<ClassesRepository>(context)
                    .getUserDetailsById(
                        user.stories[currentStoryIndex].viewed.toList()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        animating: true,
                      ),
                    );
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<UserModel> users = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listViewersTile(
                              profileUrl: users[index].photoUrl,
                              name: users[index].name,
                              userId: widget.userId,
                              email: users[index].email,
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  getChatRoomIdByUserIds(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget listViewersTile({String profileUrl, name, userId, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUserIds(userId, userId);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [userId, userId]
        };
        ChatRepository().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatRoomScreen(userId, name, profileUrl, userId)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: checkUrl(profileUrl),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget checkUrl(String url) {
    try {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => CupertinoActivityIndicator(
          animating: true,
        ),
        height: 60,
        width: 60,
      );
    } catch (e) {
      return CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.08,
          backgroundColor: Colors.grey[400].withOpacity(
            0.4,
          ),
          child: FaIcon(
            FontAwesomeIcons.user,
            color: kWhiteTextColor,
            size: MediaQuery.of(context).size.width * 0.1,
          ));
    }
  }
}

class StoryProfile extends StatefulWidget {
  final UserStories user;
  final DateTime time;

  const StoryProfile({Key key, this.user, this.time}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoryProfile();
}

class _StoryProfile extends State<StoryProfile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 42,
        height: 42,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: widget.user.profilePicURL != null
              ? CachedNetworkImage(
                  imageUrl: widget.user.profilePicURL,
                  placeholder: (context, url) => CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kButtonColor)))
              : Image.asset('assets/images/profile_image.jpg'),
        ),
      ),
      title: Text(
        widget.user.userName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        getUploadedTime(widget.time),
        style: TextStyle(color: Colors.white70),
      ),
      trailing: IconButton(
        color: Colors.white,
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
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
