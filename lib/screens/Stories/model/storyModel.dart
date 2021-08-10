import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story_view/story_view.dart';

class StoryModel{
  String fileType;
  String fileURL;
  String fileName;
  DateTime dateTime;
  Set<String> viewed = {};
  int duration;
  StoryModel({this.fileType,this.fileURL,this.dateTime,this.fileName,this.duration});

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> data = new Map();
    data["fileType"] = fileType;
    data["fileURL"] = fileURL;
    data["date"] = dateTime;
    data['fileName'] = fileName;
    data['duration'] = duration;
    data['viewed'] = viewed.toList();
    return data;
  }

  StoryModel.fromMap(Map<String, dynamic> data){
    Timestamp time = data['date'];
    this.dateTime = DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    this.fileURL = data['fileURL'];
    this.fileType = data['fileType'];
    this.fileName = data['fileName'];
    List<dynamic> viewers = data['viewed'];
    this.viewed = viewers.cast<String>().toSet();
    this.duration = data['duration'];
  }

  StoryItem getStoryItem(StoryController controller,String userID){
    if(fileType=="image"){
      return StoryItem.pageImage(url: fileURL ,duration: Duration(milliseconds: duration) , controller: controller,shown: viewed.contains(userID));
    }else
      return StoryItem.pageVideo(fileURL,duration: Duration(milliseconds: duration), controller: controller,shown: viewed.contains(userID));
  }
}