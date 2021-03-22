import 'package:flutter/foundation.dart';
import 'package:kabod_app/screens/classes/model/classes_model.dart';

//my imports
import 'package:kabod_app/screens/home/model/wod_model.dart';

class MainScreenModel extends ChangeNotifier {
  MainScreenModel({this.selectedDate, this.wodStream, this.classesStream});

  DateTime selectedDate;
  Stream<List<Wod>> wodStream;
  Stream<List<Classes>> classesStream;

  Map<DateTime, List<Wod>> _wods = {};
  Map<DateTime, List<Classes>> _classes = {};

  List<Wod> _selectedWods = [];
  List<Classes> _selectedClasses = [];

  Map<DateTime, List<Wod>> get wods => _wods;
  Map<DateTime, List<Classes>> get classes => _classes;

  List<Wod> get selectedWods => _selectedWods;
  List<Classes> get selectedClasses => _selectedClasses;

  set selectedWods(List<Wod> val) {
    _selectedWods = val;
    notifyListeners();
  }

  set selectedClasses(List<Classes> val) {
    _selectedClasses = val;
    notifyListeners();
  }

  set wods(Map<DateTime, List<Wod>> val) {
    _wods = val;
    notifyListeners();
  }

  set classes(Map<DateTime, List<Classes>> val) {
    _classes = val;
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

  groupClasses(List<Classes> classes) {
    _classes = {};
    classes.forEach((individualClass) {
      DateTime date = DateTime.utc(individualClass.classDate.year,
          individualClass.classDate.month, individualClass.classDate.day, 12);
      if (_classes[date] == null) _classes[date] = [];
      _classes[date].add(individualClass);
    });
  }

  whenSelectedDay(day) {
    selectedDate = day;
    notifyListeners();
  }
}
