import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/timers/models/tabata_model.dart';
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

class WorkoutScreen extends StatefulWidget {
  final Settings settings;
  final Tabata tabata;

  WorkoutScreen({this.settings, this.tabata});

  @override
  State<StatefulWidget> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  Workout _workoutTabata;

  @override
  initState() {
    super.initState();
    _workoutTabata = Workout(widget.settings, widget.tabata, _onWorkoutChanged);

    _start();
  }

  @override
  dispose() {
    _workoutTabata.dispose();
    Screen.keepOn(false);
    super.dispose();
  }

  _onWorkoutChanged() {
    if (_workoutTabata.step == WorkoutState.finished) {
      Screen.keepOn(false);
    }
    this.setState(() {});
  }

  _getBackgroundColor(ThemeData theme) {
    switch (_workoutTabata.step) {
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
    _workoutTabata.pause();
    Screen.keepOn(false);
  }

  _start() {
    _workoutTabata.start();
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
              Text(stepName(_workoutTabata.step),
                  style: TextStyle(fontSize: 60.0))
            ]),
            Divider(height: 32, color: lightTextColor),
            Container(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                    child: Text(formatTime(_workoutTabata.timeLeft)))),
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
                  child: Text('${_workoutTabata.set}',
                      style: TextStyle(fontSize: 60.0)),
                ),
                TableCell(
                  child: Text('${_workoutTabata.rep}',
                      style: TextStyle(fontSize: 60.0)),
                ),
                TableCell(
                    child: Text(
                  formatTime(_workoutTabata.totalTime),
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
    if (_workoutTabata.step == WorkoutState.finished) {
      return Container();
    }
    return Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
            onPressed: _workoutTabata.isActive ? _pause : _start,
            child: Icon(
                _workoutTabata.isActive ? Icons.pause : Icons.play_arrow,
                size: 60,
                color: kBackgroundColor)));
  }
}
