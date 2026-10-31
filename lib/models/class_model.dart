class TimetableSlot {
  TimetableSlot({
    required this.timeSlot,
    required this.subjectName,
    required this.room,
    required this.lecturer,
  });

  factory TimetableSlot.fromJson(Map<String, dynamic> json) {
    return TimetableSlot(
      timeSlot: json['time_slot']?.toString() ?? '',
      subjectName: json['subject_name']?.toString() ?? '',
      room: json['room']?.toString() ?? '',
      lecturer: json['lecturer']?.toString() ?? '',
    );
  }

  final String timeSlot;
  final String subjectName;
  final String room;
  final String lecturer;

  Map<String, dynamic> toJson() {
    return {
      'time_slot': timeSlot,
      'subject_name': subjectName,
      'room': room,
      'lecturer': lecturer,
    };
  }
}

class DaySchedule {
  DaySchedule({required this.dayOfWeek, required this.schedules});

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    var list = json['schedules'] as List? ?? [];
    List<TimetableSlot> scheduleList = list.map((i) => TimetableSlot.fromJson(i as Map<String, dynamic>)).toList();

    return DaySchedule(
      dayOfWeek: json['day_of_week']?.toString() ?? '',
      schedules: scheduleList,
    );
  }

  final String dayOfWeek;
  final List<TimetableSlot> schedules;

  Map<String, dynamic> toJson() {
    return {
      'day_of_week': dayOfWeek,
      'schedules': schedules.map((e) => e.toJson()).toList(),
    };
  }
}

class ClassModel {
  ClassModel({
    required this.id,
    required this.className,
    required this.major,
    required this.year,
    required this.semester,
    required this.weeklyTimetable,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    var list = json['weekly_timetable'] as List? ?? [];
    List<DaySchedule> timetableList = list.map((i) => DaySchedule.fromJson(i as Map<String, dynamic>)).toList();

    return ClassModel(
      id: json['_id'].toString(),
      className: json['class_name']?.toString() ?? '',
      major: json['major']?.toString() ?? '',
      year: json['year'] as int? ?? 1,
      semester: json['semester'] as int? ?? 1,
      weeklyTimetable: timetableList,
    );
  }

  final String id;
  final String className;
  final String major;
  final int year;
  final int semester;
  final List<DaySchedule> weeklyTimetable;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_name': className,
      'major': major,
      'year': year,
      'semester': semester,
      'weekly_timetable': weeklyTimetable.map((e) => e.toJson()).toList(),
    };
  }
}
