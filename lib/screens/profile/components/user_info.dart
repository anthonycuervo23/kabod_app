import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              'Personal information',
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
                              'Birth date',
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              df.format(userRepository.userModel.birthDate),
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
                              'email',
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
                              'phone',
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              userRepository.userModel?.phone ?? 'phone',
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
                              'joined date',
                              style: TextStyle(color: kButtonColor),
                            ),
                            subtitle: Text(
                              '${userRepository.userModel.registrationDate.day.toString()}-${userRepository.userModel.registrationDate.month.toString()}-${userRepository.userModel.registrationDate.year.toString()}',
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
