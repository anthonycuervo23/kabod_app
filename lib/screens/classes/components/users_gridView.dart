import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabod_app/core/presentation/constants.dart';

//My imports
import 'package:kabod_app/screens/auth/model/user_model.dart';

class ShowSubscribedUsers extends StatelessWidget {
  const ShowSubscribedUsers({
    Key key,
    @required this.users,
  }) : super(key: key);

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel user = users[index];
          return Column(
            children: [
              CircleAvatar(
                backgroundImage: user.photoUrl != null
                    ? CachedNetworkImageProvider(
                        user.photoUrl,
                      )
                    : null,
                radius: MediaQuery.of(context).size.width * 0.10,
                backgroundColor: Colors.grey[400].withOpacity(
                  0.4,
                ),
                child: user.photoUrl == null
                    ? FaIcon(
                        FontAwesomeIcons.user,
                        color: kWhiteTextColor,
                        size: MediaQuery.of(context).size.width * 0.1,
                      )
                    : Container(),
              ),
              Text(
                user.name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        },
      ),
    );
  }
}
