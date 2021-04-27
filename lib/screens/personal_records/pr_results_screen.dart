import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      Text('Log New Score'),
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
                      Text('Rename Exercise'),
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
                      Text('Delete Exercise'),
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
      body: Center(
        child: Text(widget.selectedExercise.exercise),
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
                              : "Enter exercise name";
                        },
                        decoration: InputDecoration(
                          hintText: "Please Enter Exercise",
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
                'New Exercise',
                style: TextStyle(
                    color: kButtonColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
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
                    'Rename',
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
            'Warning!',
            style: TextStyle(
                color: kButtonColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
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
