import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/service/notifications.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/repository/classes_repository.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/commons/show_toast.dart';
import 'package:kabod_app/screens/classes/components/users_gridView.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';

class ClassDetailScreen extends StatefulWidget {
  final Classes currentClass;
  final List<DateTime> listOfHours;
  final int index;
  final NotificationManager manager;
  ClassDetailScreen(
      {this.manager, this.currentClass, this.listOfHours, this.index});
  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  List<String> keys;
  Stream<List<UserModel>> _usersRegisteredStream;
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

  DateTime _userSubscribedToClass(String userId) {
    List<List<dynamic>> allAthletes =
        widget.currentClass.classAthletes.values.toList();
    List<DateTime> allHours =
        dateTimeFromStrings(widget.currentClass.classAthletes.keys.toList());
    for (var i = 0; i < widget.currentClass.classAthletes.length; i++) {
      List listOfAthletes = allAthletes[i];
      DateTime classHour = allHours[i];
      for (var j = 0; j < listOfAthletes.length; j++) {
        if (userId == listOfAthletes[j]) {
          return classHour;
        }
      }
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  void initState() {
    super.initState();
    keys = widget.currentClass.classAthletes.keys.toList();
    keys.sort((a, b) {
      return a.compareTo(b);
    });
    _usersRegisteredStream = context.read<ClassesRepository>().getListOfUsers(
        listUid: widget.currentClass.classAthletes[keys[widget.index]]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(
          S.of(context).appBarSchedule,
          style: TextStyle(
              color: kTextColor, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
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
            child: Text(S.of(context).classDetails,
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
                            ? S.of(context).crossfitClass
                            : 'Open Box',
                        style: TextStyle(fontSize: 24, color: kWhiteTextColor),
                      ),
                      Text(
                          DateFormat.jm()
                              .format(widget.listOfHours[widget.index])
                              .toString()
                              .toLowerCase(),
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor)),
                    ],
                  ),
                  DividerBig(),
                  Text(
                      S.of(context).athletesSubscribed(
                          widget.currentClass.classAthletes[keys[widget.index]]
                              .length,
                          widget.currentClass.maxAthletes),
                      style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          DividerMedium(),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(
              S.of(context).registerAthletes,
              style: TextStyle(fontSize: 24, color: kWhiteTextColor),
            ),
          ),
          DividerMedium(),
          StreamBuilder<List<UserModel>>(
            stream: _usersRegisteredStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                List<UserModel> users = snapshot.data;
                return ShowSubscribedUsers(users: users);
              } else if (snapshot.data == null) {
                return Center(
                    child: Text(
                  S.of(context).classEmpty,
                  style: TextStyle(fontSize: 20),
                ));
              } else
                return Center(child: Text(snapshot.error.toString()));
            },
          ),
          bookingOrCancelButton(),
          DividerMedium()
        ],
      ),
    );
  }

  Widget bookingOrCancelButton() {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    final bool userSubscribed = _isAthleteSubscribe(userRepository.user.uid);
    final DateTime userSubscribedToClass =
        _userSubscribedToClass(userRepository.user.uid);
    if (!userSubscribed &&
        widget.currentClass.classAthletes[keys[widget.index]].length <= 10) {
      return Visibility(
        visible: widget.listOfHours[widget.index].isBefore(DateTime.now()) ||
                widget.currentClass.classAthletes[keys[widget.index]].length >=
                    10
            ? false
            : true,
        child: ReusableButton(
            onPressed: () async {
              final Map<String, dynamic> data = {
                'class_athletes': {
                  keys[widget.index]:
                      FieldValue.arrayUnion([userRepository.user.uid])
                }
              };
              await context
                  .read<ClassesRepository>()
                  .addUserToClass(widget.currentClass.id, data);
              widget.manager.showNotificationDaily(
                  data,
                  'Proxima clase',
                  'Tu clase esta por empezar',
                  widget.listOfHours[widget.index].hour,
                  widget.listOfHours[widget.index].minute);
              Navigator.pop(context);
              ToastUtil.show(
                  ToastDecorator(
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading:
                              Icon(Icons.check, size: 50, color: Colors.green),
                          title: Text("Has Reservado una Clase.!",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                    backgroundColor: kBackgroundColor,
                  ),
                  context,
                  gravity: ToastGravity.top);
            },
            child: Text(
              S.of(context).bookClassButton,
              style: kTextButtonStyle,
            )),
      );
    } else if (widget.listOfHours[widget.index]
            .isAtSameMomentAs(userSubscribedToClass) &&
        widget.listOfHours[widget.index].isAfter(DateTime.now().toUtc())) {
      return ReusableButton(
          onPressed: () async {
            final Map<String, dynamic> data = {
              'class_athletes.${keys[widget.index]}':
                  FieldValue.arrayRemove([userRepository.user.uid])
            };
            await context
                .read<ClassesRepository>()
                .removeUserFromClass(widget.currentClass.id, data);
            widget.manager.removeReminder(data);
            Navigator.pop(context);
            ToastUtil.show(
                ToastDecorator(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.info_outline,
                            size: 50, color: kButtonColor),
                        title: Text("Tu reserva ha sido cancelada.",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  backgroundColor: kBackgroundColor,
                ),
                context,
                gravity: ToastGravity.top);
          },
          child: Text(
            S.of(context).cancelClassButton,
            style: kTextButtonStyle,
          ));
    }
    return Container();
  }
}
