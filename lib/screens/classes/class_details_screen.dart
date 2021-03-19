import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabod_app/core/model/classes_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';

class ClassDetailScreen extends StatefulWidget {
  final Classes currentClass;
  final int index;
  ClassDetailScreen({this.currentClass, this.index});
  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> classHours =
        widget.currentClass.classAthletes.keys.toList();
    final String currentClassHour = classHours[widget.index];
    return Scaffold(
        appBar: AppBar(
          shape: kAppBarShape,
          title: Text('Schedule'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: kButtonColor),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text('Class Details',
                  style: TextStyle(fontSize: 24, color: kWhiteTextColor)),
            ),
            DefaultCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        DateFormat('EEEE, d MMMM')
                            .format(widget.currentClass.classDate),
                        style: TextStyle(fontSize: 18)),
                    DividerBig(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.currentClass.startingHours[widget.index]
                                      .hour !=
                                  12
                              ? 'CrossFit Class'
                              : 'Open Box',
                          style:
                              TextStyle(fontSize: 24, color: kWhiteTextColor),
                        ),
                        Text(
                            DateFormat.jm()
                                .format(widget
                                    .currentClass.startingHours[widget.index])
                                .toString()
                                .toLowerCase(),
                            style: TextStyle(
                                fontSize: 24, color: kWhiteTextColor)),
                      ],
                    ),
                    DividerBig(),
                    Text(
                        '${widget.currentClass.classAthletes[currentClassHour].length} of ${widget.currentClass.maxAthletes}',
                        style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            ),
            DividerMedium(),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                'Registered Athletes',
                style: TextStyle(fontSize: 24, color: kWhiteTextColor),
              ),
            )
          ],
        ));
  }
}
