import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/chat_repository.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/chat/components/full_photo.dart';
import 'package:kabod_app/screens/chat/components/loading.dart';
import 'package:kabod_app/screens/chat/helpers/sharedPreferences_helper.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatWithUserId, name, profilePic, myId;
  ChatRoomScreen(this.chatWithUserId, this.name, this.profilePic, this.myId);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name,
            style: TextStyle(fontSize: 24, color: kTextColor)),
      ),
      body: ChatScreen(
          chatWithUserId: widget.chatWithUserId,
          profilePic: widget.profilePic,
          myId: widget.myId),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatWithUserId;
  final String profilePic;
  final String myId;
  ChatScreen(
      {Key key, @required this.chatWithUserId, this.profilePic, this.myId})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
      chatWithUserId: chatWithUserId, profilePic: profilePic, myId: myId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState(
      {Key key, @required this.chatWithUserId, this.profilePic, this.myId});

  String chatWithUserId;
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  String profilePic;
  String myId;

  String chatRoomId, messageId = "";
  Stream messageStream;
  String myName, myProfilePic, myUserId, myEmail;
  TextEditingController messageTextEdittingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;

  getMyInfoFromSharedPreference() async {
    myUserId = await SharedPreferenceHelper().getUserId();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUsernames(widget.chatWithUserId, myUserId);
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(String message, bool sendClicked, int type) {
    if (message.trim() != '') {
      messageTextEdittingController.clear();
      var lastMessageTs = DateTime.now().millisecondsSinceEpoch.toString();

      var documentReference = FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(chatRoomId)
          .collection('chats')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            "message": message,
            "idFrom": myUserId,
            "idTo": widget.chatWithUserId,
            "ts": lastMessageTs,
            "imgUrl": myProfilePic,
            "type": type
          },
        );
      }).then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserId
        };

        ChatRepository().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEdittingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: S.of(context).emptyMessage,
          backgroundColor: kButtonColor,
          textColor: Colors.black);
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == myUserId) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
              // Text
              ? Container(
                  child: Text(
                    document.data()['message'],
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : document.data()['type'] == 1
                  // Image
                  ? Container(
                      child: TextButton(
                        child: Material(
                          child: CachedNetworkImage(
                            imageUrl: document.data()['message'],
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(kButtonColor),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'assets/images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullPhoto(
                                      url: document.data()['message'])));
                        },
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: Image.asset(
                        'assets/gif/${document.data()['message']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          imageUrl: widget.profilePic,
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kButtonColor),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document.data()['type'] == 0
                    ? Container(
                        child: Text(
                          document.data()['message'],
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(0),
                          ),
                          color: Color(0xff687980),
                        ),
                        // decoration: BoxDecoration(
                        //     color: kButtonColor,
                        //     borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document.data()['type'] == 1
                        ? Container(
                            child: TextButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  imageUrl: document.data()['message'],
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kButtonColor),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'assets/images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document.data()['message'])));
                              },
                              //padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: Image.asset(
                              'assets/gif/${document.data()['message']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.data()['ts']))),
                      style: TextStyle(
                          color: kButtonColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['sendBy'] == myUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['sendBy'] != myUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Color(0xff687980),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ],
    );
  }

  getAndSetMessages() async {
    messageStream =
        await ChatRepository().getChatRoomMessages(chatRoomId, _limit);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 16),
                    itemCount: snapshot.data.docs.length,
                    controller: listScrollController,
                    reverse: true,
                    itemBuilder: (context, index) {
                      listMessage.addAll(snapshot.data.docs);
                      return buildItem(index, snapshot.data.docs[index]);
                    }),
              )
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kButtonColor)));
      },
    );
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    readLocal();

    doThisOnLaunch();
    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
    super.initState();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'chattingWith': widget.chatWithUserId});

    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    TaskSnapshot uploadTask = await reference.putFile(imageFile);
    var storageTaskSnapshot =
        await uploadTask.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        addMessage(imageUrl, true, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: S.of(context).notAnImage);
    });
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(myUserId)
          .update({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              chatMessages(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => addMessage('mimi1', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi1.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi2', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi2.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi3', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi3.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => addMessage('mimi4', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi4.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi5', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi5.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi6', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi6.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => addMessage('mimi7', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi7.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi8', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi8.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    onPressed: () => addMessage('mimi9', true, 2),
                    child: Image.asset(
                      'assets/gif/mimi9.gif',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kTextColor, width: 0.5)),
          color: kTextColor),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const Loading() : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: kPrimaryColor,
              ),
            ),
            color: kWhiteTextColor,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: getSticker,
                color: kPrimaryColor,
              ),
            ),
            color: kWhiteTextColor,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  addMessage(messageTextEdittingController.text, true, 0);
                },
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: messageTextEdittingController,
                decoration: InputDecoration.collapsed(
                  hintText: S.of(context).typeMessage,
                  hintStyle: TextStyle(color: kBackgroundColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    addMessage(messageTextEdittingController.text, true, 0),
                color: kPrimaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kWhiteTextColor, width: 0.5)),
          color: Colors.white),
    );
  }
}
