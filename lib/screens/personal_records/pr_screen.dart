import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';

//My imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/personal_records/components/exercisesList.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class PersonalRecordsScreen extends StatefulWidget {
  @override
  _PersonalRecordsScreenState createState() => _PersonalRecordsScreenState();
}

class _PersonalRecordsScreenState extends State<PersonalRecordsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _exerciseController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ApiService api = ApiService();
  List<Exercise> exercisesList;
  List<Exercise> filterExerciseList = [];
  Future _future;

  Future loadList() {
    Future<List<Exercise>> futureExercises = api.getExercises();
    futureExercises.then((exercisesList) {
      if (mounted)
        setState(() {
          this.filterExerciseList = this.exercisesList = exercisesList;
        });
    });
    return futureExercises;
  }

  @override
  void initState() {
    super.initState();
    _future = loadList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (exercisesList == null) {
      exercisesList = [];
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: Text(
          S.of(context).appBarPersonalRecords,
          style: TextStyle(fontSize: 24, color: kTextColor),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: MyDrawer(AppRoutes.personalRecordsRoute),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.12,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.12 - 27,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular((10)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 54,
                    decoration: BoxDecoration(
                      color: kWhiteTextColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: kBackgroundColor),
                      onChanged: (value) {
                        _filterExercises(value);
                      },
                      decoration: InputDecoration(
                          hintText: S.of(context).searchExercise,
                          hintStyle:
                              TextStyle(color: kPrimaryColor, fontSize: 18),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: kPrimaryColor,
                            size: 30,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
          DividerSmall(),
          Expanded(
            child: Container(
              child: Center(
                child: FutureBuilder(
                    future: _future,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kButtonColor),
                          );
                        default:
                          if (snapshot.hasError) {
                            print("Error on PR SCREEN: ${snapshot.error}");
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.error),
                                  Text(S.of(context).unexpectedError)
                                ],
                              ),
                            );
                          } else if (!snapshot.hasData) {
                            return Center(
                                child: Text(
                              S.of(context).noExercise,
                              style: TextStyle(fontSize: 24),
                            ));
                          } else {
                            filterExerciseList.forEach((element) => element
                                .results
                                .forEach((element) => print(element)));
                            return filterExerciseList.length > 0
                                ? ExercisesList(
                                    exercises: filterExerciseList,
                                    fetch: _future)
                                : Text(S.of(context).noExercise);
                          }
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExerciseDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _filterExercises(value) {
    setState(() {
      filterExerciseList = exercisesList
          .where((Exercise exercise) =>
              exercise.exercise.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showAddExerciseDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: kBackgroundColor,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _exerciseController,
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : S.of(context).enterExerciseName;
                        },
                        decoration: InputDecoration(
                          hintText: S.of(context).exerciseHint,
                          hintStyle: TextStyle(color: kTextColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kButtonColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kButtonColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: kButtonColor),
                          ),
                        ),
                      ),
                    ],
                  )),
              title: Text(
                S.of(context).newExercise,
                style: TextStyle(
                    color: kButtonColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(
                        color: kButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      api
                          .createExercise(
                              Exercise(exercise: _exerciseController.text))
                          .then((Exercise exercise) {
                        if (exercise != null) {
                          loadList();
                        }
                      });
                      _exerciseController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    S.of(context).create,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          });
        });
  }
}
