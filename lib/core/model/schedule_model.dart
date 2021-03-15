class Schedule {
  String id;
  DateTime classDate;
  List usersList7am;
  List usersList8am;
  List usersList9am;
  List usersList10am;
  List usersList11am;
  List usersList12pm;
  List usersList3pm;
  List usersList4pm;
  List usersList5pm;

  Schedule(
      {this.id,
      this.classDate,
      this.usersList7am,
      this.usersList8am,
      this.usersList9am,
      this.usersList10am,
      this.usersList11am,
      this.usersList12pm,
      this.usersList3pm,
      this.usersList4pm,
      this.usersList5pm});

  Schedule.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        classDate = DateTime.fromMillisecondsSinceEpoch(data['class_date']),
        usersList7am = data['users_list7am'],
        usersList8am = data['users_list8am'],
        usersList9am = data['users_list9am'],
        usersList10am = data['users_list10am'],
        usersList11am = data['users_list11am'],
        usersList12pm = data['users_list12pm'],
        usersList3pm = data['users_list3pm'],
        usersList4pm = data['users_list4pm'],
        usersList5pm = data['users_list5pm'];

  toJson() {
    return {
      'class_date': classDate,
      'users_list7am': usersList7am,
      'users_list8am': usersList8am,
      'users_list9am': usersList9am,
      'users_list10am': usersList10am,
      'users_list11am': usersList11am,
      'users_list12pm': usersList12pm,
      'users_list3pm': usersList3pm,
      'users_list4pm': usersList4pm,
      'users_list5pm': usersList5pm,
    };
  }
}
