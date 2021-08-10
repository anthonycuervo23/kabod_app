import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabod_app/screens/Stories/model/storyModel.dart';

class UserStories {
  String userID;
  String userName;
  String profilePicURL;
  DateTime dateTime;
  List<StoryModel> stories = [];

  UserStories(
      {this.userName,
      this.userID,
      this.stories,
      this.profilePicURL,
      this.dateTime});

  Map<String, dynamic> toMap({List stories}) {
    final Map<String, dynamic> data = new Map();
    data['_id'] = userID;
    data['username'] = userName;
    data['profilePic'] = profilePicURL;
    data['date'] = dateTime;
    if (stories == null || stories.length == 0) {
      stories = [];
      this.stories.forEach((element) {
        stories.add(element.toMap());
      });
    }
    data['stories'] = stories;
    return data;
  }

  UserStories.fromMap(Map<String, dynamic> data) {
    this.userID = data['_id'];
    Timestamp time = data['date'];
    this.dateTime =
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    this.userName = data['username'];
    this.profilePicURL = data['profilePic'];
    List stories = data['stories'];
    if (stories != null)
      stories.forEach((element) {
        Timestamp time = element['date'];
        if (time.compareTo(Timestamp.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch -
                    Duration.millisecondsPerDay)) >
            0) this.stories.add(StoryModel.fromMap(element));
      });
  }

  UserStories.getSingleStory(UserStories user , StoryModel story){
    this.userID = user.userID;
    this.userName = user.userName;
    this.dateTime = user.dateTime;
    this.profilePicURL = user.profilePicURL;
    this.stories.add(story);
  }
}
