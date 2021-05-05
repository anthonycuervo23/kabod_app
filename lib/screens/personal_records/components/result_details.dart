import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/generated/l10n.dart';
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
  Duration duration = Duration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerMedium(),
            Text(
                widget.results[widget.index].createdAt != null
                    ? DateFormat('MMMM d, y').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.results[widget.index].createdAt))
                    : 'No Date',
                style: TextStyle(
                    color: kWhiteTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            DividerSmall(),
            durationFromString(widget.results[widget.index].time) != duration
                ? Text(S.of(context).prTime(widget.results[widget.index].time),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].reps != null
                ? Text(
                    S
                        .of(context)
                        .prReps(widget.results[widget.index].reps.toString()),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].weight != null
                ? Text(
                    S.of(context).prWeight(widget.results[widget.index].weight),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            widget.results[widget.index].comment != null
                ? Text(
                    S
                        .of(context)
                        .prComment(widget.results[widget.index].comment),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            ButtonTheme(
              child: ButtonBar(
                children: [
                  TextButton(
                    child: const Text('Editar',
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
                    child: const Text('Borrar',
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
            S.of(context).warning,
            style: TextStyle(
                color: kButtonColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
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
