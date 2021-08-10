import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/generated/l10n.dart';
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
          // player.play(value);
        },
      ),
      title: Text(title, style: kTimerInputStyle),
      subtitle: DropdownButton<String>(
        dropdownColor: kPrimaryColor,
        isDense: true,
        value: value,
        items: [
          DropdownMenuItem(
              child: Text(S.of(context).lowBeep), value: 'pip.mp3'),
          DropdownMenuItem(
              child: Text(S.of(context).highBeep), value: 'boop.mp3'),
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
        title: Text(S.of(context).timerSettings,
            style: TextStyle(fontSize: 30, color: kTextColor)),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            activeColor: kButtonColor,
            title: Text(S.of(context).silenceMode, style: kTimerInputStyle),
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
              S.of(context).sounds,
              style: kTimerHeadersStyle,
            ),
          ),
          AudioSelectListItem(
            value: widget.settings.countdownPip,
            title: S.of(context).countdownPips,
            onChanged: (String value) {
              setState(() {
                widget.settings.countdownPip = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startRep,
            title: S.of(context).startNextRep,
            onChanged: (String value) {
              setState(() {
                widget.settings.startRep = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startRest,
            title: S.of(context).rest,
            onChanged: (String value) {
              setState(() {
                widget.settings.startRest = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startBreak,
            title: S.of(context).breakTimer,
            onChanged: (String value) {
              setState(() {
                widget.settings.startBreak = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.startSet,
            title: S.of(context).startNextSet,
            onChanged: (String value) {
              setState(() {
                widget.settings.startSet = value;
                widget.onSettingsChanged();
              });
            },
          ),
          AudioSelectListItem(
            value: widget.settings.endWorkout,
            title: S.of(context).endWorkout,
            onChanged: (String value) {
              setState(() {
                widget.settings.endWorkout = value;
                widget.onSettingsChanged();
              });
            },
          ),
        ],
      ),
    );
  }
}
