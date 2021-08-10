import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/Stories/model/userStories.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';

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
    print(user.stories.length);
    print(storyItems.length);
    print(user.toMap());
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
              onComplete:
                  widget.onComplete ?? () => Navigator.of(context).pop(),
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
              Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(user.stories[currentStoryIndex].viewed?.length
                          .toString() ??
                      "0")),
          ],
        ),
      ),
    );
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
      title: Text(widget.user.userName,style: TextStyle(fontWeight: FontWeight.bold),),
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
