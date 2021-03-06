import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    final df = DateFormat('MMMM d, y');
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).personalInformation,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            elevation: 0,
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all((Radius.circular(10)))),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(
                              Icons.home,
                              color: kButtonColor,
                            ),
                            title: Text(
                              S.of(context).introBirthDate,
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              df.format(userRepository.userModel?.birthDate),
                              style: TextStyle(
                                  fontSize: 20, color: kWhiteTextColor),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: kButtonColor,
                            ),
                            title: Text(
                              'Email',
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              userRepository.userModel?.email,
                              style: TextStyle(
                                  fontSize: 20, color: kWhiteTextColor),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: kButtonColor,
                            ),
                            title: Text(
                              S.of(context).introPhone,
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              userRepository.userModel?.phone ??
                                  S.of(context).introPhone,
                              style: TextStyle(
                                  fontSize: 20, color: kWhiteTextColor),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.calendar_today,
                              color: kButtonColor,
                            ),
                            title: Text(
                              S.of(context).joinedDate,
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              DateFormat('MMMM d, y').format(
                                  userRepository.userModel?.registrationDate),
                              style: TextStyle(
                                  fontSize: 20, color: kWhiteTextColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
