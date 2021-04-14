import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class LeaderBoardCard extends StatelessWidget {
  final Widget userName;
  final Widget place;
  final String score;
  final Widget type;
  final Widget commentPhoto;
  final Widget comment;
  final ImageProvider picture;
  final Widget pictureIcon;

  LeaderBoardCard(
      {this.userName,
      this.type,
      this.score,
      this.comment,
      this.commentPhoto,
      this.picture,
      this.pictureIcon,
      this.place});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(66.0, 8.0, 0.0, 0.0),
              // constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: userName),
                      Expanded(flex: 1, child: place),
                    ],
                  ),
                  Text(score,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  comment,
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.0,
                      width: 18.0,
                      color: Color(0xff00c6ff)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[type]),
                        ),
                      ),
                      Container(width: 8.0),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  commentPhoto,
                                ]),
                          )),
                      Container(width: 8.0),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            //height: 164.0,
            margin: EdgeInsets.only(left: 46.0),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            alignment: FractionalOffset.centerLeft,
            child: CircleAvatar(
                radius: 45,
                backgroundImage: picture,
                backgroundColor: Colors.grey[400].withOpacity(
                  0.4,
                ),
                child: pictureIcon),
          ),
        ],
      ),
    );
  }
}
