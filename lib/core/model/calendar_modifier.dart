import 'package:flutter/foundation.dart';

//my imports
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModifier extends ChangeNotifier {
  CalendarController _calendarController = CalendarController();

  CalendarController get calendarController => _calendarController;

  set calendarController(CalendarController val) {
    _calendarController = val;
    notifyListeners();
  }

  Map<DateTime, List<Wod>> _wods = {};

  List<Wod> _selectedWods = [];

  Map<DateTime, List<Wod>> get wods => _wods;

  List<Wod> get selectedWods => _selectedWods;

  set selectedWods(List<Wod> val) {
    _selectedWods = val;
    notifyListeners();
  }

  set wods(Map<DateTime, List<Wod>> val) {
    _wods = val;
    notifyListeners();
  }

  groupWods(List<Wod> wods) {
    _wods = {};
    wods.forEach((wod) {
      DateTime date =
          DateTime.utc(wod.date.year, wod.date.month, wod.date.day, 12);
      if (_wods[date] == null) _wods[date] = [];
      _wods[date].add(wod);
    });
  }

  whenSelectedDay({wod}) {
    selectedWods = wod.cast<Wod>();
    notifyListeners();
  }
}
