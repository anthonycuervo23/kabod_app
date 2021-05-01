import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

//My imports
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/timers/models/emom_model.dart';
import 'package:kabod_app/screens/timers/models/settings_model.dart';

String stepName(WorkoutState step) {
  switch (step) {
    case WorkoutState.exercising:
      return 'Exercise';
    case WorkoutState.resting:
      return 'Rest';
    case WorkoutState.breaking:
      return 'Break';
    case WorkoutState.finished:
      return 'Finished';
    case WorkoutState.starting:
      return 'Starting';
    default:
      return '';
  }
}

class WorkoutEmomScreen extends StatefulWidget {
  final Settings settings;
  final Emom emom;

  WorkoutEmomScreen({this.settings, this.emom});

  @override
  State<StatefulWidget> createState() => _WorkoutEmomScreenState();
}

class _WorkoutEmomScreenState extends State<WorkoutEmomScreen> {
  EmomWorkout _workout;

  @override
  initState() {
    super.initState();
    _workout = EmomWorkout(widget.settings, widget.emom, _onWorkoutChanged);

    _start();
  }

  @override
  dispose() {
    _workout.dispose();
    Screen.keepOn(false);
    super.dispose();
  }

  _onWorkoutChanged() {
    if (_workout.step == WorkoutState.finished) {
      Screen.keepOn(false);
    }
    this.setState(() {});
  }

  _getBackgroundColor(ThemeData theme) {
    switch (_workout.step) {
      case WorkoutState.exercising:
        return Colors.green;
      case WorkoutState.starting:
      case WorkoutState.resting:
        return Colors.blue;
      case WorkoutState.breaking:
        return Colors.red;
      default:
        return theme.scaffoldBackgroundColor;
    }
  }

  _pause() {
    _workout.pause();
    Screen.keepOn(false);
  }

  _start() {
    _workout.start();
    Screen.keepOn(true);
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lightTextColor = theme.textTheme.bodyText2.color.withOpacity(0.8);
    return Scaffold(
      body: Container(
        color: _getBackgroundColor(theme),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Expanded(child: Row()),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(stepName(_workout.step), style: TextStyle(fontSize: 60.0))
            ]),
            Divider(height: 32, color: lightTextColor),
            Container(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(child: Text(formatTime(_workout.timeLeft)))),
            Divider(height: 32, color: lightTextColor),
            Table(columnWidths: {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(1.0)
            }, children: [
              TableRow(children: [
                TableCell(child: Text('Set', style: TextStyle(fontSize: 30.0))),
                TableCell(child: Text('Rep', style: TextStyle(fontSize: 30.0))),
                TableCell(
                    child: Text('Total Time',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 30.0)))
              ]),
              TableRow(children: [
                TableCell(
                  child:
                      Text('${_workout.set}', style: TextStyle(fontSize: 60.0)),
                ),
                TableCell(
                  child:
                      Text('${_workout.rep}', style: TextStyle(fontSize: 60.0)),
                ),
                TableCell(
                    child: Text(
                  formatTime(_workout.totalTime),
                  style: TextStyle(fontSize: 60.0),
                  textAlign: TextAlign.right,
                ))
              ]),
            ]),
            Expanded(child: _buildButtonBar()),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    if (_workout.step == WorkoutState.finished) {
      return Container();
    }
    return Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
            onPressed: _workout.isActive ? _pause : _start,
            child: Icon(_workout.isActive ? Icons.pause : Icons.play_arrow)));
  }
}
