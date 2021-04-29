import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/personal_records/components/result_details.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';

class ResultsList extends StatelessWidget {
  final List<Result> results;
  final Exercise selectedExercise;
  ResultsList({Key key, this.results, this.selectedExercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: results == null ? 0 : results.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 0,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              child: ResultDetailWidget(
                  results: results,
                  index: index,
                  selectedExercise: selectedExercise));
        });
  }
}
