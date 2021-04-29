import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class ResultDetailWidget extends StatefulWidget {
  const ResultDetailWidget(
      {Key key, @required this.results, this.selectedExercise, this.index})
      : super(key: key);

  final List<Result> results;
  final Exercise selectedExercise;
  final int index;

  @override
  _ResultDetailWidgetState createState() => _ResultDetailWidgetState();
}

class _ResultDetailWidgetState extends State<ResultDetailWidget> {
  _ResultDetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerMedium(),
            Text('Abr 20, 2021',
                style: TextStyle(
                    color: kWhiteTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            DividerSmall(),
            widget.results[widget.index].time != null
                ? Text('Time: ${widget.results[widget.index].time}',
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].reps != null
                ? Text('Reps: ${widget.results[widget.index].reps.toString()}',
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].weight != null
                ? Text('Weight: ${widget.results[widget.index].weight} lb',
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].comment != null
                ? Text('Comment: ${widget.results[widget.index].comment}',
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            ButtonTheme(
              child: ButtonBar(
                children: [
                  TextButton(
                    child: const Text('Edit',
                        style: TextStyle(color: kWhiteTextColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.editResultRoute,
                          arguments: [
                            widget.results[widget.index],
                            widget.selectedExercise
                          ]);
                    },
                  ),
                  TextButton(
                    child: const Text('Delete',
                        style: TextStyle(color: kWhiteTextColor)),
                    onPressed: () {
                      _confirmDeleteDialog();
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
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
              children: [
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: kTextColor, fontSize: 18),
              ),
              onPressed: () {
                api.deleteResult(widget.results[widget.index].id);
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
