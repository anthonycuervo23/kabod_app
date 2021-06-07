import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/personal_records/components/result_details.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class ResultsList extends StatefulWidget {
  final List<Result> results;
  final Exercise selectedExercise;
  ResultsList({Key key, this.results, this.selectedExercise}) : super(key: key);

  _ResultsList createState() => _ResultsList();
}

class _ResultsList extends State<ResultsList> {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.results == null ? 0 : widget.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              //key: ValueKey(widget.results[index].createdAt),
              elevation: 0,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              child: ResultDetailWidget(
                  result: widget.results[index],
                  index: index,
                  onDelete: (int index) {
                    _confirmDeleteDialog(context, index);
                  },
                  onEdit: (int index) {
                    print(widget.results[index].time);
                    Navigator.pushNamed(context, AppRoutes.editResultRoute,
                        arguments: [
                          widget.results[index],
                          widget.selectedExercise
                        ]);
                  }));
        });
  }

  Future<void> _confirmDeleteDialog(BuildContext context, int index) async {
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
              onPressed: () async {
                await api.deleteResult(widget.results[index].id);
                setState(() {
                  widget.results.removeAt(index);
                });
                Navigator.of(context).pop();
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
