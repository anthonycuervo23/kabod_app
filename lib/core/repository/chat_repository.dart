import 'package:cloud_firestore/cloud_firestore.dart';

//My imports
import 'package:kabod_app/screens/chat/helpers/sharedPreferences_helper.dart';

class ChatRepository {
  getUserList() async {
    var data = await FirebaseFirestore.instance.collection("users").get();
    return data.docs;
  }

  Future addMessage(String chatRoomId, String messageId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(
      chatRoomId, int limit) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUserId = await SharedPreferenceHelper().getUserId();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUserId)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("user_id", isEqualTo: userId)
        .get();
  }
}
