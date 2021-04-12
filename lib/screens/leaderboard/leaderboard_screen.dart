import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/utils/general_utils.dart';

//My Imports
import 'package:kabod_app/screens/leaderboard/components/leaderboard_cards.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> allWodNames = [];
  List<Result> _filteredList = [];
  List<String> filteredWodNames;
  String _dropDownGender;
  DateTime _dropDownDate;
  String _dropDownWodName;
  int i = 0;
  bool disableWodName = true;
  bool disableGender = true;
  bool firstTime = true;

  @override
  void initState() {
    listOfResultsFilteredByDate();
    super.initState();
  }

  static List<Result> allResultsListByDate = [];

  Future<void> listOfResultsFilteredByDate() async {
    List listOfUsers = await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((val) => val.docs);
    for (int i = 0; i < listOfUsers.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(listOfUsers[i].id.toString())
          .collection("results")
          .where('result_date', isEqualTo: _dropDownDate)
          .orderBy('time', descending: false)
          .snapshots()
          .listen(createListOfResultsByDate);
    }
    setState(() {
      allResultsListByDate = _filteredList;
    });
  }

  Future<List<Result>> _getListByDate() async {
    return allResultsListByDate;
  }

  createListOfResultsByDate(QuerySnapshot snapshot) async {
    var docs = snapshot.docs;
    for (var Doc in docs) {
      allResultsListByDate.add(Result.fromFireStore(Doc));
    }
  }

  static List<Result> allResultsListByWodName = [];

  Future<void> listOfResultsFilteredByWodName() async {
    List listOfUsers = await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((val) => val.docs);
    for (int i = 0; i < listOfUsers.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(listOfUsers[i].id.toString())
          .collection("results")
          .where('wod_date', isEqualTo: _dropDownDate)
          .orderBy('time', descending: false)
          .snapshots()
          .listen(createListOfResultsByWodName);
    }
    setState(() {
      allResultsListByWodName = _filteredList;
    });
  }

  Future<List<Result>> _getListByWodName() async {
    return allResultsListByWodName;
  }

  createListOfResultsByWodName(QuerySnapshot snapshot) async {
    var docs = snapshot.docs;
    for (var Doc in docs) {
      allResultsListByWodName.add(Result.fromFireStore(Doc));
    }
  }

  static List<Result> allResultsListByWodNameAndGender = [];

  Future<void> listOfResultsFilteredByWodNameAndGender(
      DateTime selectedDate, String wodName) async {
    List listOfUsers = await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((val) => val.docs);
    for (int i = 0; i < listOfUsers.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(listOfUsers[i].id.toString())
          .collection("results")
          .where('wod_date', isEqualTo: selectedDate)
          .where('wod_name', isEqualTo: wodName)
          .orderBy('time', descending: false)
          .snapshots()
          .listen(createListOfResultsByWodNameAndGender);
    }
    setState(() {
      allResultsListByWodNameAndGender = _filteredList;
    });
  }

  Future<void> _getlListByWodNameAndGender() async {
    return allResultsListByWodNameAndGender;
  }

  createListOfResultsByWodNameAndGender(QuerySnapshot snapshot) async {
    var docs = snapshot.docs;
    for (var Doc in docs) {
      allResultsListByWodNameAndGender.add(Result.fromFireStore(Doc));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle kNameStyle = TextStyle(fontSize: 20, color: Colors.white);
    TextStyle medalSize = TextStyle(fontSize: 40);
    return Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(
          scaffoldKey: _scaffoldKey,
          shape: kAppBarShape,
          title: Text(
            'Leader Board',
            style: TextStyle(
                color: kTextColor, fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: MyDrawer(AppRoutes.leaderBoardRoute),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.3 - 27,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Column(
                            children: [
                              getWodDateDropdown(),
                              getWodNameDropdown(disableWodName),
                              getGenderDropdown(disableGender),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  DividerSmall(),
                  _filteredList.length == 0 && firstTime == true
                      ? Center(
                          child: Text('PLEASE ENTER SOME FILTERS TO SEARCH',
                              style: TextStyle(fontSize: 24)))
                      : _filteredList.length == 0 && firstTime == false
                          ? Center(
                              child: Text('NO DATA FOUND',
                                  style: TextStyle(fontSize: 24)))
                          : Expanded(
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
                                    return InkWell(
                                      onTap: _filteredList[index].photoUrl ==
                                              null
                                          ? null
                                          : () => Navigator.pushNamed(context,
                                              AppRoutes.pictureDetailsRoute,
                                              arguments: _filteredList[index]
                                                  .photoUrl),
                                      child: LeaderBoardCard(
                                        userName: Text(
                                            _filteredList[index].userName,
                                            style: kNameStyle),
                                        score: _filteredList[index].rounds ==
                                                null
                                            ? stringFromDuration(
                                                _filteredList[index].time)
                                            : '${_filteredList[index].rounds.toString()} Rounds ${_filteredList[index].reps.toString()} reps',
                                        type: new Text(
                                            _filteredList[index].rx == true
                                                ? 'RX'
                                                : 'scale',
                                            style: _filteredList[index].rx ==
                                                    true
                                                ? TextStyle(
                                                    fontSize: 18,
                                                    color: kButtonColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic)
                                                : TextStyle(
                                                    fontSize: 14,
                                                    color: kTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic)),
                                        place: i == 0
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
                                                    : SizedBox(height: 50),
                                        comment: _filteredList[index].comment !=
                                                null
                                            ? Text(_filteredList[index].comment)
                                            : Container(),
                                        picture: _filteredList[index]
                                                    .userPhoto !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                _filteredList[index].userPhoto,
                                              )
                                            : null,
                                        pictureIcon:
                                            _filteredList[index].userPhoto ==
                                                    null
                                                ? FaIcon(
                                                    FontAwesomeIcons.user,
                                                    color: kWhiteTextColor,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.1,
                                                  )
                                                : Container(),
                                        commentPhoto:
                                            _filteredList[index].photoUrl !=
                                                    null
                                                ? FaIcon(
                                                    FontAwesomeIcons.image,
                                                    size: 20,
                                                    color: kTextColor,
                                                  )
                                                : Container(),
                                      ),
                                    );
                                  }),
                            )
                ],
              ),
            )
          ],
        ));
  }

  Widget getWodDateDropdown() {
    final format = DateFormat("EEEE d MMMM, y");
    return FutureBuilder(
        future: _getListByDate(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Result> result = snapshot.data;
            i = 0;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: kButtonColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DateTimeField(
                  decoration: (InputDecoration(
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                        size: 35,
                      ),
                      hintStyle: TextStyle(
                          color: kTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      hintText: 'Select Date')),
                  style: TextStyle(
                    fontSize: 18,
                    color: kWhiteTextColor,
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(2021, 3, 21),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime.now());
                  },
                  onChanged: (newValue) {
                    setState(() {
                      listOfResultsFilteredByWodName();
                      print(result[0].wodType);
                      _dropDownDate = newValue;
                      firstTime = false;
                      disableWodName = false;
                      _dropDownWodName = null;
                      _dropDownGender = null;
                      setState(() {
                        _filteredList = result
                            .where((Result item) => item.date == _dropDownDate)
                            .toList();
                      });
                    });
                  },
                ),
              ),
            );
          } else {
            return Center(
              child: Text('PLEASE ENTER A VALID DATE TO SEE THE SCORES'),
            );
          }
        });
  }

  Widget getWodNameDropdown(enableDropDown) {
    return FutureBuilder(
        future: _getListByWodName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Result> result = snapshot.data;
            for (int j = 0; j < result.length; j++) {
              Result itemResult = result[j];
              allWodNames.add(itemResult.wodName);
            }
            filteredWodNames = allWodNames.toSet().toList();

            i = 0;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: kButtonColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IgnorePointer(
                  ignoring: enableDropDown,
                  child: DropdownButton(
                    items: filteredWodNames
                            .toList()
                            ?.map<DropdownMenuItem>(
                              (wodName) => DropdownMenuItem(
                                child: Text(wodName),
                                value: '$wodName',
                              ),
                            )
                            ?.toList() ??
                        [],
                    onChanged: (newValue) {
                      setState(() {
                        listOfResultsFilteredByWodNameAndGender(
                          _dropDownDate,
                          _dropDownWodName,
                        );
                        disableGender = false;
                        _dropDownWodName = newValue;
                        _dropDownGender = null;
                        setState(() {
                          _filteredList = result
                              .where((Result item) =>
                                  item.wodName.toLowerCase() ==
                                      _dropDownWodName.toLowerCase() &&
                                  item.date == _dropDownDate)
                              .toList();
                        });
                      });
                    },
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    underline: SizedBox(),
                    hint: Text(
                      'WOD Name: ',
                      style: TextStyle(color: kTextColor, fontSize: 18),
                    ),
                    dropdownColor: kBackgroundColor,
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18),
                    //isExpanded: true,
                    value: _dropDownWodName,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('NO RESULTS FOUND FOR THIS FILTERING'),
            );
          }
        });
  }

  Widget getGenderDropdown(enableDropDown) {
    return FutureBuilder(
        future: _getlListByWodNameAndGender(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Result> result = snapshot.data;
            i = 0;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: kButtonColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IgnorePointer(
                  ignoring: enableDropDown,
                  child: DropdownButton<String>(
                    value: _dropDownGender,
                    onChanged: (String newValue) {
                      setState(() {
                        _dropDownGender = newValue;

                        if (_dropDownGender == "All") {
                          setState(() {
                            // no search field input, display all items
                            _filteredList = result;
                          });
                        } else {
                          setState(() {
                            _filteredList = result
                                .where((Result result) =>
                                    result.gender.toLowerCase() ==
                                    _dropDownGender.toLowerCase())
                                .toList();
                          });
                        }
                      });
                    },
                    items: <String>[
                          'All',
                          'Male',
                          'Female',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })?.toList() ??
                        [],
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    underline: SizedBox(),
                    hint: Text(
                      'Gender: ',
                      style: TextStyle(color: kTextColor, fontSize: 18),
                    ),
                    dropdownColor: kBackgroundColor,
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('NO RESULTS FOUND FOR THIS FILTERING'),
            );
          }
        });
  }
}
