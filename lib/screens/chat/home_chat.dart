import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/chat_repository.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/chat/chat_room.dart';
import 'package:kabod_app/screens/chat/helpers/sharedPreferences_helper.dart';
import 'package:kabod_app/screens/commons/appbar.dart';

class HomeChatScreen extends StatefulWidget {
  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearching = false;
  String myName, myProfilePic, myUserId, myEmail;
  Stream chatRoomsStream;

  TextEditingController athleteNameController = TextEditingController();
  List allUsers = [];
  List filteredUsers = [];
  Future usersLoaded;

  getMyInfoFromSharedPreference() async {
    myUserId = await SharedPreferenceHelper().getUserId();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getChatRoomIdByUserIds(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  _onSearchChanged() {
    getFilteredUsers();
  }

  getFilteredUsers() {
    var showFilteredUsers = [];
    if (athleteNameController.text != '') {
      for (var user in allUsers) {
        var name = UserModel.fromSnapshot(user).name.toLowerCase();

        if (name.contains(athleteNameController.text.toLowerCase())) {
          showFilteredUsers.add(user);
        }
      }
    } else {
      showFilteredUsers = List.from(allUsers);
    }
    setState(() {
      filteredUsers = showFilteredUsers;
    });
  }

  getAllUsers() async {
    allUsers = await ChatRepository().getUserList();
    setState(() {});
    getFilteredUsers();
  }

  Widget chatRoomsList() {
    print(myName);
    print(myUserId);
    print(myEmail);
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Snapshot Error receiving chatrooms"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length == 0) {
              return Center(child: Text("No user found"));
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot ds = snapshot.data.docs[index];
                return ChatRoomListTile(
                    ds.data()["lastMessage"], ds.id, myUserId);
              },
            );
          } else {
            return Text("");
          }
        });
  }

  Widget searchListUserTile({String profileUrl, name, userId, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUserIds(myUserId, userId);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserId, userId]
        };
        ChatRepository().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatRoomScreen(userId, name, profileUrl)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                profileUrl,
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return ListView.builder(
      itemCount: filteredUsers.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        QueryDocumentSnapshot ds = filteredUsers[index];
        return searchListUserTile(
            profileUrl: ds.data()["photo_url"],
            name: ds.data()["name"],
            userId: ds.data()["user_id"],
            email: ds.data()['email']);
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await ChatRepository().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    athleteNameController.addListener(_onSearchChanged);
    onScreenLoaded();
    super.initState();
  }

  @override
  void dispose() {
    athleteNameController.removeListener(_onSearchChanged);
    athleteNameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersLoaded = getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: Text(
          'KABOD CHAT',
          style: TextStyle(fontSize: 30, color: kTextColor),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: MyDrawer(AppRoutes.chatRoute),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    isSearching
                        ? GestureDetector(
                            onTap: () {
                              isSearching = false;
                              athleteNameController.text = "";
                              setState(() {});
                            },
                            child: Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_back,
                                    color: kButtonColor)),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: kWhiteTextColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              style: TextStyle(
                                  fontSize: 18, color: kBackgroundColor),
                              onTap: () {
                                isSearching = true;
                              },
                              controller: athleteNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Athlete Name",
                                hintStyle:
                                    TextStyle(color: kTextColor, fontSize: 18),
                              ),
                            )),
                            GestureDetector(
                                child: Icon(
                              Icons.search,
                              size: 30,
                              color: kButtonColor,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isSearching ? searchUsersList() : chatRoomsList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await ChatRepository().getUserInfo(username);
    print(widget.myUsername);
    name = "${querySnapshot.docs[0].data()["name"]}";
    profilePicUrl = "${querySnapshot.docs[0].data()["photo_url"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatRoomScreen(username, name, profilePicUrl)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                profilePicUrl,
                height: 55,
                width: 55,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                      widget.lastMessage.contains('http')
                          ? 'Open image...'
                          : widget.lastMessage,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
