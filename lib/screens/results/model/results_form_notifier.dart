import 'package:flutter/material.dart';

class ResultFormNotifier extends ChangeNotifier {
  bool rx = false;
  Duration initialTimer = Duration();
  void changeRxValue(bool newRx) {
    rx = newRx;
    notifyListeners();
  }

  void changeInitialTimerValue(Duration newInitialTimer) {
    initialTimer = newInitialTimer;
    notifyListeners();
  }
}
