import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/personal_records/components/resultsList.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class ResultsScreen extends StatefulWidget {
  final Exercise selectedExercise;
  ResultsScreen({this.selectedExercise});
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _exerciseController = TextEditingController();
  final ApiService api = ApiService();
  List<Result> resultsList;

  @override
  void initState() {
    super.initState();
    resultsList = widget.selectedExercise.results;
  }

  @override
  Widget build(BuildContext context) {
    if (resultsList == null) {
      resultsList = [];
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.selectedExercise.exercise,
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              color: kBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: kButtonColor,
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).newPr),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: kButtonColor,
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).renameExercise),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: kButtonColor,
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).deleteExercise),
                    ],
                  ),
                ),
              ],
              child: Icon(
                Icons.more_vert,
                size: 40,
                color: kButtonColor,
              ),
              onSelected: (int menu) {
                if (menu == 1) {
                  Navigator.pushNamed(context, AppRoutes.addResultRoute,
                      arguments: widget.selectedExercise);
                } else if (menu == 2) {
                  _showEditExerciseDialog(context);
                } else if (menu == 3) {
                  _confirmDeleteDialog();
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
            child: resultsList.length > 0
                ? ResultsList(
                    results: resultsList,
                    selectedExercise: widget.selectedExercise)
                : Center(
                    child: Text(
                      S.of(context).noExerciseFound,
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
      ),
    );
  }

  Future<void> _showEditExerciseDialog(BuildContext context) async {
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
              actions: [
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
                      api.updateExercise(
                          widget.selectedExercise.id,
                          Exercise(
                              exercise: _exerciseController.text,
                              uid: Provider.of<UserRepository>(context,
                                      listen: false)
                                  .user
                                  .uid));
                      _exerciseController.clear();
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  },
                  child: Text(
                    S.of(context).rename,
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

  Future<void> _confirmDeleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBackgroundColor,
          title: Text(
            S.of(context).warning,
            style: TextStyle(
                color: kButtonColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).confirmDialog),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                S.of(context).yes,
                style: TextStyle(color: kTextColor, fontSize: 18),
              ),
              onPressed: () {
                api.deleteExercise(widget.selectedExercise.id);
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: kTextColor, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
