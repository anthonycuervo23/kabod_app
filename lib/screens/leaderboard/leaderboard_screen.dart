import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//My Imports
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/leaderboard_repository.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  Stream<List<Result>> _resultStream;
  List<String> allGenders = [];
  List allWodNames = [];
  List allWodDates = [];
  List<Result> _filteredList = [];
  String _dropDownGender;
  DateTime _dropDownDate;
  String test;
  String _dropDownWodName;
  int i = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _resultStream =
        context.read<LeaderBoardRepository>().getResults('time', true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var medalSize = TextStyle(fontSize: 40);
    return Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(
          scaffoldKey: _scaffoldKey,
          shape: kAppBarShape,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: MyDrawer(AppRoutes.leaderBoardRoute),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
                child: StreamBuilder<List<Result>>(
                    stream: _resultStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Result> result = snapshot.data;
                        for (int j = 0; j < result.length; j++) {
                          Result itemResult = result[j];
                          allGenders.add(itemResult.gender);
                          allWodNames.add(itemResult.wodName);
                          allWodDates.add(itemResult.date);
                        }
                        final List<String> filteredGenders =
                            allGenders.toSet().toList();
                        final List filteredWodNames =
                            allWodNames.toSet().toList();
                        final List filteredWodDates =
                            allWodDates.toSet().toList();
                        i = 0;
                        return Column(
                          children: [
                            DividerSmall(),
                            DefaultCard(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.calendar_today,
                                      size: 40,
                                      color: kButtonColor,
                                    ),
                                    trailing: DropdownButton(
                                      items: filteredWodDates
                                              .map<DropdownMenuItem>(
                                                (wodDate) => DropdownMenuItem(
                                                  child:
                                                      Text(wodDate.toString()),
                                                  value: '$wodDate',
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (newValue) {
                                        setState(() {
                                          print(filteredWodDates);
                                          test = newValue;
                                          setState(() {
                                            _filteredList = result
                                                .where((Result item) =>
                                                    item.date ==
                                                    DateTime.parse(test))
                                                .toList();
                                          });
                                        });
                                      },
                                      hint: Text(
                                        'WOD Date: ',
                                        style: TextStyle(
                                            color: kWhiteTextColor,
                                            fontSize: 18),
                                      ),
                                      dropdownColor: kBackgroundColor,
                                      style: TextStyle(
                                          color: kTextColor, fontSize: 18),
                                      //isExpanded: true,
                                      value: _dropDownDate,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.api_sharp,
                                      size: 40,
                                      color: kButtonColor,
                                    ),
                                    trailing: DropdownButton(
                                      items: filteredWodNames
                                              .map<DropdownMenuItem>(
                                                (wodName) => DropdownMenuItem(
                                                  child: Text(wodName),
                                                  value: '$wodName',
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (newValue) {
                                        setState(() {
                                          print(filteredGenders);
                                          _dropDownWodName = newValue;
                                          setState(() {
                                            _filteredList = result
                                                .where((Result item) =>
                                                    item.wodName
                                                        .toLowerCase() ==
                                                    _dropDownWodName
                                                        .toLowerCase())
                                                .toList();
                                          });
                                        });
                                      },
                                      hint: Text(
                                        'WOD Name: ',
                                        style: TextStyle(
                                            color: kWhiteTextColor,
                                            fontSize: 18),
                                      ),
                                      dropdownColor: kBackgroundColor,
                                      style: TextStyle(
                                          color: kTextColor, fontSize: 18),
                                      //isExpanded: true,
                                      value: _dropDownWodName,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: kButtonColor,
                                    ),
                                    trailing: DropdownButton(
                                      items: filteredGenders
                                              .map<DropdownMenuItem>(
                                                (gender) => DropdownMenuItem(
                                                  child: Text(gender),
                                                  value: '$gender',
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (newValue) {
                                        setState(() {
                                          print(filteredGenders);
                                          _dropDownGender = newValue;
                                          setState(() {
                                            _filteredList = result
                                                .where((Result item) =>
                                                    item.gender.toLowerCase() ==
                                                    _dropDownGender
                                                        .toLowerCase())
                                                .toList();
                                          });
                                        });
                                      },
                                      hint: Text(
                                        'Gender: ',
                                        style: TextStyle(
                                            color: kWhiteTextColor,
                                            fontSize: 18),
                                      ),
                                      dropdownColor: kBackgroundColor,
                                      style: TextStyle(
                                          color: kTextColor, fontSize: 18),
                                      //isExpanded: true,
                                      value: _dropDownGender,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DividerSmall(),
                            RichText(
                                text: TextSpan(
                                    text: "Leader",
                                    style: TextStyle(
                                        color: kButtonColor,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                      text: " Board",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold))
                                ])),
                            DividerSmall(),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: _filteredList.length,
                                  itemBuilder: (context, index) {
                                    print(index);
                                    if (index >= 1) {
                                      print('Greater than 1');
                                      if (_filteredList[index].rounds ==
                                          _filteredList[index - 1].rounds) {
                                        print('Same');
                                      } else {
                                        i++;
                                      }
                                    }

                                    return DefaultCard(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Transform.translate(
                                              offset: Offset(-30, 0),
                                              child: CircleAvatar(
                                                backgroundImage: _filteredList[
                                                                index]
                                                            .userPhoto !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        _filteredList[index]
                                                            .userPhoto,
                                                      )
                                                    : null,
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                backgroundColor: Colors
                                                    .grey[400]
                                                    .withOpacity(
                                                  0.4,
                                                ),
                                                child: _filteredList[index]
                                                            .userPhoto ==
                                                        null
                                                    ? FaIcon(
                                                        FontAwesomeIcons.user,
                                                        color: kWhiteTextColor,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                      )
                                                    : Container(),
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(-30, 0),
                                              child: Text(
                                                _filteredList[index].userName,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: kWhiteTextColor),
                                              ),
                                            ),
                                            subtitle: Transform.translate(
                                              offset: Offset(-30, 0),
                                              child: Text(
                                                _filteredList[index].rounds ==
                                                        null
                                                    ? _filteredList[index].time
                                                    : '${_filteredList[index].rounds.toString()} and ${_filteredList[index].reps.toString()} reps',
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            trailing: i == 0
                                                ? Text("🥇", style: medalSize)
                                                : i == 1
                                                    ? Text(
                                                        "🥈",
                                                        style: medalSize,
                                                      )
                                                    : i == 2
                                                        ? Text(
                                                            "🥉",
                                                            style: medalSize,
                                                          )
                                                        : Text(''),
                                          ),
                                          ListTile(
                                            leading: _filteredList[index].rx ==
                                                    true
                                                ? Text(
                                                    'RX',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kButtonColor),
                                                  )
                                                : null,
                                            title:
                                                _filteredList[index].comment !=
                                                        null
                                                    ? Text(_filteredList[index]
                                                        .comment)
                                                    : null,
                                            trailing: InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: kButtonColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                    }))
          ],
        ));
  }
}
