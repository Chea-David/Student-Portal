
class SubjectGrade {
  SubjectGrade({
    required this.subjectName,
    required this.score,
    required this.gradeLetter,
  });

  factory SubjectGrade.fromJson(Map<String, dynamic> json) {
    return SubjectGrade(
      subjectName: json['subject_name']?.toString() ?? '',
      score: json['score']?.toString() ?? '0',
      gradeLetter: json['grade_letter']?.toString() ?? 'F',
    );
  }

  final String subjectName;
  final String score;
  final String gradeLetter;

  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'score': score,
      'grade_letter': gradeLetter,
    };
  }
}

class SemesterGrade {
  SemesterGrade({
    required this.year,
    required this.semester,
    required this.subjects,
  });

  factory SemesterGrade.fromJson(Map<String, dynamic> json) {
    var list = json['subjects'] as List? ?? [];
    List<SubjectGrade> subjectList = list.map((i) => SubjectGrade.fromJson(i as Map<String, dynamic>)).toList();

    return SemesterGrade(
      year: json['year']?.toString() ?? '',
      semester: json['semester']?.toString() ?? '',
      subjects: subjectList,
    );
  }

  final String year;
  final String semester;
  final List<SubjectGrade> subjects;

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'semester': semester,
      'subjects': subjects.map((e) => e.toJson()).toList(),
    };
  }
}
