class CourseSchedule {
  CourseSchedule({required this.days, required this.timeSlot});

  factory CourseSchedule.fromJson(Map<String, dynamic> json) {
    return CourseSchedule(
      days: json['days']?.toString() ?? '',
      timeSlot: json['time_slot']?.toString() ?? '',
    );
  }

  final String days;
  final String timeSlot;

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'time_slot': timeSlot,
    };
  }
}

class CourseModel {
  CourseModel({
    required this.id,
    required this.courseTitle,
    required this.duration,
    required this.price,
    required this.logoUrl,
    required this.description,
    required this.schedules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    var list = json['schedules'] as List? ?? [];
    List<CourseSchedule> scheduleList = list.map((i) => CourseSchedule.fromJson(i as Map<String, dynamic>)).toList();

    return CourseModel(
      id: json['_id'].toString(),
      courseTitle: json['course_title']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      price: json['price'] as int? ?? 0,
      logoUrl: json['logo_url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      schedules: scheduleList,
    );
  }

  final String id;
  final String courseTitle;
  final String duration;
  final int price;
  final String logoUrl;
  final String description;
  final List<CourseSchedule> schedules;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_title': courseTitle,
      'duration': duration,
      'price': price,
      'logo_url': logoUrl,
      'description': description,
      'schedules': schedules.map((e) => e.toJson()).toList(),
    };
  }
}
