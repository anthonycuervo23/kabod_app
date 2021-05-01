import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences sharedPrefs;
  init() async {
    if (sharedPrefs == null) {
      sharedPrefs = await SharedPreferences.getInstance();
    }
  }
}

final sharedPrefs = SharedPrefs();
