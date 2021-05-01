import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/timers/models/settings_model.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;

  final Function onSettingsChanged;

  SettingsScreen({@required this.settings, @required this.onSettingsChanged});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class AudioSelectListItem extends StatelessWidget {
  final String title;
  final String value;
  final Function(String) onChanged;

  AudioSelectListItem(
      {@required this.title, @required this.onChanged, this.value});

  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: Icon(Icons.play_circle_outline, color: kButtonColor),
        onPressed: () {
          player.play(value);
        },
      ),
      title: Text(title, style: kTimerInputStyle),
      subtitle: DropdownButton<String>(
        isDense: true,
        value: value,
        items: [
          DropdownMenuItem(child: Text('Low Beep'), value: 'pip.mp3'),
          DropdownMenuItem(child: Text('High Beep'), value: 'boop.mp3'),
          DropdownMenuItem(
              child: Text('Ding Ding Ding!'), value: 'dingdingding.mp3'),
        ],
        isExpanded: true,
        onChanged: onChanged,
      ),
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Settings', style: TextStyle(fontSize: 30, color: kTextColor)),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            activeColor: kButtonColor,
            title: Text('Silent mode', style: kTimerInputStyle),
            value: widget.settings.silentMode,
            onChanged: (silentMode) {
              setState(() {
                widget.settings.silentMode = silentMode;
                widget.onSettingsChanged();
              });
            },
          ),
          Divider(height: 10),
          ListTile(
            title: Text(
              'Sounds',
              style: kTimerHeadersStyle,
            ),
          ),
          AudioSelectListItem(
            value: widget.settings.countdownPip,
            title: 'Countdown pips',
            onChanged: (String value) {
              setState(() {
                widget.settings.countdownPip = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startRep,
            title: 'Start next rep',
            onChanged: (String value) {
              setState(() {
                widget.settings.startRep = value;
                widget.onSettingsChanged();
              });
              // widget.settings.startRep = value;
              // widget.onSettingsChanged();
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startRest,
            title: 'Rest',
            onChanged: (String value) {
              setState(() {
                widget.settings.startRest = value;
                widget.onSettingsChanged();
              });
              // widget.settings.startRest = value;
              // widget.onSettingsChanged();
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startBreak,
            title: 'Break',
            onChanged: (String value) {
              setState(() {
                widget.settings.startBreak = value;
                widget.onSettingsChanged();
              });
              // widget.settings.startBreak = value;
              // widget.onSettingsChanged();
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startSet,
            title: 'Start next set',
            onChanged: (String value) {
              setState(() {
                widget.settings.startSet = value;
                widget.onSettingsChanged();
              });
              // widget.settings.startSet = value;
              // widget.onSettingsChanged();
            },
          ),
          AudioSelectListItem(
            value: widget.settings.endWorkout,
            title: 'End workout (plays twice)',
            onChanged: (String value) {
              setState(() {
                widget.settings.endWorkout = value;
                widget.onSettingsChanged();
              });
              // widget.settings.endWorkout = value;
              // widget.onSettingsChanged();
            },
          ),
        ],
      ),
    );
  }
}
