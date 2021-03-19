import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/model/classes_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/classes_repository.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:provider/provider.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  Stream<List<Classes>> _classesStream;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _classesStream = context.read<ClassesRepository>().getClassesOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: Text('Schedule'),
        shape: kAppBarShape,
      ),
      body: StreamBuilder<List<Classes>>(
        stream: _classesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Classes>> snapshot) {
          if (snapshot.hasData) {
            final List<Classes> currentClass = snapshot.data;
            final List<String> classHours =
                currentClass[0].classAthletes.keys.toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DividerMedium(),
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Text(
                    'Today\'s Schedule',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                DividerMedium(),
                Expanded(
                  child: ListView.separated(
                    itemCount: currentClass[0].startingHours.length,
                    itemBuilder: (context, index) {
                      final String currentClassHour = classHours[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.classDetailsRoute,
                            arguments: [currentClass[0], index]),
                        child: DefaultCard(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    DateFormat.jm()
                                        .format(currentClass[0]
                                            .startingHours[index])
                                        .toString()
                                        .toLowerCase(),
                                    style: TextStyle(
                                        fontSize: 22, color: kWhiteTextColor),
                                  ),
                                  Text(DateFormat('E d, MMM')
                                      .format(currentClass[0].classDate)
                                      .toString()),
                                ],
                              ),
                              Flexible(
                                child: ListTile(
                                  title: Text(
                                    currentClass[0].startingHours[index].hour !=
                                            12
                                        ? 'CrossFit Class'
                                        : 'Open Box',
                                    style: TextStyle(
                                        fontSize: 24, color: kWhiteTextColor),
                                  ),
                                  subtitle: Text(
                                    '${currentClass[0].classAthletes[currentClassHour].length} / ${currentClass[0].maxAthletes} Participants',
                                    style: TextStyle(color: kTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 28,
                                    color: kButtonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => DividerMedium(),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
