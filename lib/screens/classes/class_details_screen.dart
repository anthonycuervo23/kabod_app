import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/screens/classes/repository/classes_repository.dart';
import 'package:kabod_app/screens/auth/model/user_repository.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';

class ClassDetailScreen extends StatefulWidget {
  final Classes currentClass;
  final List<DateTime> listOfHours;
  final int index;
  ClassDetailScreen({this.currentClass, this.listOfHours, this.index});
  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  bool _isAthleteSubscribe(String userId) {
    List allAthletes = widget.currentClass.classAthletes.values.toList();
    for (var i = 0; i < widget.currentClass.classAthletes.length; i++) {
      List listOfAthletes = allAthletes[i];
      for (var j = 0; j < listOfAthletes.length; j++) {
        if (userId == listOfAthletes[j]) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    print(widget.index);
    List keys = widget.currentClass.classAthletes.keys.toList();
    keys.sort((a, b) {
      return a.compareTo(b);
    });
    final bool userSubscribed = _isAthleteSubscribe(userRepository.user.uid);
    return Scaffold(
        appBar: AppBar(
          shape: kAppBarShape,
          title: Text('Schedule'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: kButtonColor),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text('Class Details',
                  style: TextStyle(fontSize: 24, color: kWhiteTextColor)),
            ),
            DefaultCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        DateFormat('EEEE, d MMMM')
                            .format(widget.currentClass.classDate),
                        style: TextStyle(fontSize: 18)),
                    DividerBig(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.listOfHours[widget.index].hour != 12
                              ? 'CrossFit Class'
                              : 'Open Box',
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor),
                        ),
                        Text(
                            DateFormat.jm()
                                .format(widget.listOfHours[widget.index])
                                .toString()
                                .toLowerCase(),
                            style: TextStyle(
                                fontSize: 24, color: kWhiteTextColor)),
                      ],
                    ),
                    DividerBig(),
                    Text(
                        '${widget.currentClass.classAthletes[keys[widget.index]].length} of ${widget.currentClass.maxAthletes}',
                        style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            ),
            DividerMedium(),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                'Registered Athletes',
                style: TextStyle(fontSize: 24, color: kWhiteTextColor),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: widget
                    .currentClass.classAthletes[keys[widget.index]].length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        // backgroundImage:
                        // ,
                        radius: MediaQuery.of(context).size.width * 0.12,
                        backgroundColor: Colors.grey[400].withOpacity(
                          0.4,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          color: kWhiteTextColor,
                          size: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      Text(
                        'user name',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ),
            widget.listOfHours[widget.index].isAfter(DateTime.now().toUtc()) &&
                    widget.currentClass.classAthletes[keys[widget.index]]
                            .length <
                        10
                ? ReusableButton(
                    onPressed: !userSubscribed
                        ? () async {
                            final Map<String, dynamic> data = {
                              'class_athletes': {
                                keys[widget.index]: FieldValue.arrayUnion(
                                    [userRepository.user.uid])
                              }
                            };
                            await context
                                .read<ClassesRepository>()
                                .addUserToClass(widget.currentClass.id, data);
                            Navigator.pop(context);
                          }
                        : () async {
                            final Map<String, dynamic> data = {
                              'class_athletes.${keys[widget.index]}':
                                  FieldValue.arrayRemove(
                                      [userRepository.user.uid])
                            };
                            await context
                                .read<ClassesRepository>()
                                .removeUserFromClass(
                                    widget.currentClass.id, data);
                            Navigator.pop(context);
                          },
                    child: Text(
                      !userSubscribed ? 'BOOK' : 'CANCEL BOOKING',
                      style: kTextButtonStyle,
                    ))
                : Container(),
            DividerMedium()
          ],
        ));
  }
}
