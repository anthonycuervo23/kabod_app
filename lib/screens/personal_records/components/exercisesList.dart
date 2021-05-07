import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';

class ExercisesList extends StatelessWidget {
  final List<Exercise> exercises;
  final Future fetch;
  ExercisesList({Key key, this.exercises, this.fetch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exercises == null ? 0 : exercises.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 0,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context, AppRoutes.resultsRoute,
                    arguments: [exercises[index], fetch]),
                child: ListTile(
                  leading: Icon(Icons.star, color: kButtonColor, size: 40),
                  title: Text(
                    exercises[index].exercise,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ));
        });
  }
}
