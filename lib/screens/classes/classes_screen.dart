import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/model/classes_model.dart';
import 'package:kabod_app/core/repository/classes_repository.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:provider/provider.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  Stream<List<Classes>> _classesStream;

  @override
  void initState() {
    super.initState();
    _classesStream = context.read<ClassesRepository>().getClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Classes>>(
        stream: _classesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Classes>> snapshot) {
          if (snapshot.hasData) {
            final List<Classes> currentClass = snapshot.data;
            final List<String> classHours = [
              '7am_class',
              '8am_class',
              '9am_class',
              '10am_class',
              '11am_class',
              '12pm_class',
              '3pm_class',
              '4pm_class',
              '5pm_class'
            ];
            return ListView.builder(
              itemCount: currentClass[0].startingHours.length,
              itemBuilder: (context, index) {
                String currentClassHour = classHours[index];
                return DefaultCard(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: Text(
                            DateFormat.jm()
                                .format(currentClass[0].startingHours[index])
                                .toString()
                                .toLowerCase(),
                            style: TextStyle(fontSize: 22),
                          ),
                          subtitle: Text(DateFormat('E d, MMM')
                              .format(currentClass[0].classDate)
                              .toString()),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: ListTile(
                          title: Text(
                            'CrossFit Class',
                            style: TextStyle(fontSize: 24),
                          ),
                          subtitle: Text(
                              '${currentClass[0].classAthletes[currentClassHour].length} / ${currentClass[0].maxAthletes} Participants'),
                          trailing: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//////////////////////
// final List<String> classHours = [
//   '7am_class',
//   '8am_class',
//   '9am_class',
//   '10am_class',
//   '11am_class',
//   '12pm_class',
//   '3pm_class',
//   '4pm_class',
//   '5pm_class'
// ];
// return ListView.builder(
// itemCount: currentClasses.length,
// itemBuilder: (BuildContext context, int index) {
// Classes currentClass = currentClasses[index];
// String currentClassHour = classHours[index];
// return DefaultCard(
// child: Row(
// children: [
// Flexible(
// flex: 1,
// child: ListTile(
// title: Text(
// DateFormat.jm()
//     .format(currentClass.startingHours[0])
//     .toString(),
// style: TextStyle(fontSize: 22),
// ),
// subtitle: Text(DateFormat('E d, MMM')
//     .format(currentClass.classDate)
//     .toString()),
// ),
// ),
// Flexible(
// flex: 3,
// child: ListTile(
// title: Text(
// currentClass.classDate.toString(),
// style: TextStyle(fontSize: 24),
// ),
// subtitle: Text(
// '${currentClass.classAthletes[currentClassHour].length} / ${currentClass.maxAthletes} Participants'),
// trailing: Icon(Icons.arrow_drop_down),
// ),
// ),
// ],
// ),
// );
// });
