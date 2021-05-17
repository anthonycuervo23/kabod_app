import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

var player = AudioCache(prefix: 'assets/sounds/');

class Settings {
  final SharedPreferences _prefs;

  bool silentMode;
  String countdownPip;
  String startRep;
  String startRest;
  String startBreak;
  String startSet;
  String endWorkout;

  Settings(this._prefs) {
    Map<String, dynamic> json =
        jsonDecode(_prefs.getString('settings') ?? '{}');
    silentMode = json['silentMode'] ?? false;
    countdownPip = json['countdownPip'] ?? 'pip.mp3';
    startRep = json['startRep'] ?? 'boop.mp3';
    startRest = json['startRest'] ?? 'dingdingding.mp3';
    startBreak = json['startBreak'] ?? 'dingdingding.mp3';
    startSet = json['startSet'] ?? 'boop.mp3';
    endWorkout = json['endWorkout'] ?? 'dingdingding.mp3';
  }

  Settings settings;

  save() {
    _prefs.setString('settings', jsonEncode(this));
  }

  Map<String, dynamic> toJson() => {
        'silentMode': silentMode,
        'countdownPip': countdownPip,
        'startRep': startRep,
        'startRest': startRest,
        'startBreak': startBreak,
        'startSet': startSet,
        'endWorkout': endWorkout,
      };
}
