import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/timers/settings_screen.dart';
import 'package:kabod_app/screens/timers/workout_screen.dart';
import 'package:kabod_app/screens/timers/components/durationpicker.dart';
import 'package:kabod_app/screens/timers/components/round_icon_button.dart';
import 'package:kabod_app/screens/timers/emom_timer_screen.dart';
import 'package:kabod_app/screens/timers/models/emom_model.dart';
import 'package:kabod_app/screens/timers/models/settings_model.dart';
import 'package:kabod_app/screens/timers/models/tabata_model.dart';

class TabataScreen extends StatefulWidget {
  final Settings settings;
  final SharedPreferences prefs;

  TabataScreen({
    @required this.settings,
    @required this.prefs,
  });

  @override
  State<StatefulWidget> createState() => _TabataScreenState();
}

class _TabataScreenState extends State<TabataScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _onSettingsChanged() {
    setState(() {});
    widget.settings.save();
  }

  Tabata _tabata;
  Emom _emom;

  @override
  initState() {
    var tabataJson = widget.prefs.getString('tabata');
    _tabata = tabataJson != null
        ? Tabata.fromJson(jsonDecode(tabataJson))
        : defaultTabata;
    var emomJson = widget.prefs.getString('emom');
    _emom =
        emomJson != null ? Emom.fromJson(jsonDecode(emomJson)) : defaultEmom;
    super.initState();
  }

  _onTabataChanged() {
    setState(() {});
    _saveTabata();
    _saveEmom();
  }

  _saveTabata() {
    widget.prefs.setString('tabata', jsonEncode(_tabata.toJson()));
  }

  _saveEmom() {
    widget.prefs.setString('emom', jsonEncode(_emom.toJson()));
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(S.of(context).appBarTimers,
              style: TextStyle(fontSize: 22, color: kTextColor)),
          leading: IconButton(
            icon: Image.asset('assets/icons/drawer_icon.png'),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: widget.settings.silentMode
                    ? Icon(Icons.volume_off, color: kButtonColor)
                    : Icon(Icons.volume_up),
                onPressed: () {
                  widget.settings.silentMode = !widget.settings.silentMode;
                  _onSettingsChanged();
                  var snackBar = SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(S.of(context).silentModeActive(
                          !widget.settings.silentMode ? 'de' : '')));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                tooltip: 'Toggle silent mode',
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                        settings: widget.settings,
                        onSettingsChanged: _onSettingsChanged),
                  ),
                );
              },
              tooltip: 'Settings',
            ),
          ],
          bottom: TabBar(
            tabs: [Tab(text: 'TABATA'), Tab(text: 'EMOM')],
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: MyDrawer(AppRoutes.timersRoute),
        ),
        body: TabBarView(children: [
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('Sets', style: kTimerHeadersStyle),
                subtitle: Text('${_tabata.sets}', style: kTimerInputStyle),
                leading: Icon(Icons.fitness_center, color: kButtonColor),
                onTap: () {
                  showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dialogBackgroundColor: kBackgroundColor),
                        child: NumberPickerDialog.integer(
                          confirmWidget:
                              Text('OK', style: TextStyle(color: kTextColor)),
                          cancelWidget: Text(S.of(context).cancelTimer,
                              style: TextStyle(color: kTextColor)),
                          selectedTextStyle:
                              TextStyle(fontSize: 24, color: kButtonColor),
                          minValue: 1,
                          maxValue: 10,
                          initialIntegerValue: _tabata.sets,
                          title: Text(S.of(context).setsWorkout),
                        ),
                      );
                    },
                  ).then((sets) {
                    if (sets == null) return;
                    _tabata.sets = sets;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title: Text(S.of(context).reps, style: kTimerHeadersStyle),
                subtitle: Text('${_tabata.reps}', style: kTimerInputStyle),
                leading: Icon(Icons.repeat, color: kButtonColor),
                onTap: () {
                  showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dialogBackgroundColor: kBackgroundColor),
                        child: NumberPickerDialog.integer(
                          confirmWidget:
                              Text('OK', style: TextStyle(color: kTextColor)),
                          cancelWidget: Text(S.of(context).cancelTimer,
                              style: TextStyle(color: kTextColor)),
                          selectedTextStyle:
                              TextStyle(fontSize: 24, color: kButtonColor),
                          minValue: 1,
                          maxValue: 20,
                          initialIntegerValue: _tabata.reps,
                          title: Text(S.of(context).repsWorkout),
                        ),
                      );
                    },
                  ).then((reps) {
                    if (reps == null) return;
                    _tabata.reps = reps;
                    _onTabataChanged();
                  });
                },
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text(S.of(context).startingCountdown,
                    style: kTimerHeadersStyle),
                subtitle: Text(formatTime(_tabata.startDelay),
                    style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.startDelay,
                        title: Text(S.of(context).countDownBeforeWorkout),
                      );
                    },
                  ).then((startDelay) {
                    if (startDelay == null) return;
                    _tabata.startDelay = startDelay;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title:
                    Text(S.of(context).exerciseTime, style: kTimerHeadersStyle),
                subtitle: Text(formatTime(_tabata.exerciseTime),
                    style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.exerciseTime,
                        title: Text(S.of(context).exerciseTimePerRepetition),
                      );
                    },
                  ).then((exerciseTime) {
                    if (exerciseTime == null) return;
                    _tabata.exerciseTime = exerciseTime;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title: Text(S.of(context).restTime, style: kTimerHeadersStyle),
                subtitle:
                    Text(formatTime(_tabata.restTime), style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.restTime,
                        title: Text(S.of(context).restTimeBetweenRepetitions),
                      );
                    },
                  ).then((restTime) {
                    if (restTime == null) return;
                    _tabata.restTime = restTime;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title: Text(S.of(context).breakTime, style: kTimerHeadersStyle),
                subtitle: Text(formatTime(_tabata.breakTime),
                    style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.breakTime,
                        title: Text(S.of(context).breakTimeBetweenSets),
                      );
                    },
                  ).then((breakTime) {
                    if (breakTime == null) return;
                    _tabata.breakTime = breakTime;
                    _onTabataChanged();
                  });
                },
              ),
              Divider(height: 10),
              ListTile(
                title: Text(
                  S.of(context).totalTime,
                  style: kTimerHeadersStyle,
                ),
                subtitle: Text(formatTime(_tabata.getTotalTime()),
                    style: kTimerInputStyle),
                leading: Icon(Icons.timelapse, color: kButtonColor),
              ),
              RoundIconButton(
                icon: Icons.play_arrow,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutScreen(
                              settings: widget.settings, tabata: _tabata)));
                },
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('Sets', style: kTimerHeadersStyle),
                subtitle: Text('${_emom.sets}', style: kTimerInputStyle),
                leading: Icon(Icons.fitness_center, color: kButtonColor),
                onTap: () {
                  showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dialogBackgroundColor: kBackgroundColor),
                        child: NumberPickerDialog.integer(
                          confirmWidget:
                              Text('OK', style: TextStyle(color: kTextColor)),
                          cancelWidget: Text(S.of(context).cancelTimer,
                              style: TextStyle(color: kTextColor)),
                          selectedTextStyle:
                              TextStyle(fontSize: 24, color: kButtonColor),
                          minValue: 1,
                          maxValue: 10,
                          initialIntegerValue: _emom.sets,
                          title: Text(S.of(context).chooseTheAmountOfEmom),
                        ),
                      );
                    },
                  ).then((sets) {
                    if (sets == null) return;
                    _emom.sets = sets;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title: Text(S.of(context).reps, style: kTimerHeadersStyle),
                subtitle: Text('${_emom.reps}', style: kTimerInputStyle),
                leading: Icon(Icons.repeat, color: kButtonColor),
                onTap: () {
                  showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dialogBackgroundColor: kBackgroundColor),
                        child: NumberPickerDialog.integer(
                          confirmWidget:
                              Text('OK', style: TextStyle(color: kTextColor)),
                          cancelWidget: Text(S.of(context).cancelTimer,
                              style: TextStyle(color: kTextColor)),
                          selectedTextStyle:
                              TextStyle(fontSize: 24, color: kButtonColor),
                          minValue: 1,
                          maxValue: 10,
                          initialIntegerValue: _emom.reps,
                          title: Text(S.of(context).setsInsideTheEmom),
                        ),
                      );
                    },
                  ).then((reps) {
                    if (reps == null) return;
                    _emom.reps = reps;
                    _onTabataChanged();
                  });
                },
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text(S.of(context).startingCountdown,
                    style: kTimerHeadersStyle),
                subtitle:
                    Text(formatTime(_emom.startDelay), style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _emom.startDelay,
                        title: Text(S.of(context).countDownBeforeWorkout),
                      );
                    },
                  ).then((startDelay) {
                    if (startDelay == null) return;
                    _emom.startDelay = startDelay;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title:
                    Text(S.of(context).typeOfEmom, style: kTimerHeadersStyle),
                subtitle: Text(formatTime(_emom.exerciseTime),
                    style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationEmomPickerDialog(
                        initialDuration: _emom.exerciseTime,
                        title: Text(S.of(context).setEmom),
                      );
                    },
                  ).then((exerciseTime) {
                    if (exerciseTime == null) return;
                    _emom.exerciseTime = exerciseTime;
                    _onTabataChanged();
                  });
                },
              ),
              ListTile(
                title: Text(S.of(context).breakTime, style: kTimerHeadersStyle),
                subtitle:
                    Text(formatTime(_emom.breakTime), style: kTimerInputStyle),
                leading: Icon(Icons.timer, color: kButtonColor),
                onTap: () {
                  showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _emom.breakTime,
                        title: Text(S.of(context).breakTimeBetweenEmom),
                      );
                    },
                  ).then((breakTime) {
                    if (breakTime == null) return;
                    _emom.breakTime = breakTime;
                    _onTabataChanged();
                  });
                },
              ),
              Divider(height: 10),
              ListTile(
                title: Text(
                  S.of(context).totalTimeTimer,
                  style: kTimerHeadersStyle,
                ),
                subtitle: Text(
                  formatTime(_emom.getTotalTime()),
                  style: kTimerInputStyle,
                ),
                leading: Icon(Icons.timelapse, color: kButtonColor),
              ),
              RoundIconButton(
                icon: Icons.play_arrow,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutEmomScreen(
                                settings: widget.settings,
                                emom: _emom,
                              )));
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
