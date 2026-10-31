class UserModel {
  UserModel({
    required this.id,
    required this.studentId,
    required this.email,
    required this.nameKh,
    required this.nameEn,
    required this.gender,
    required this.dob,
    required this.nationality,
    required this.statusFamily,
    required this.phone,
    required this.pob,
    required this.currentAddress,
    required this.job,
    required this.fatherName,
    required this.motherName,
    required this.profileAvatar,
    required this.classId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'].toString(),
      studentId: json['student_id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nameKh: json['name_kh']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      dob: json['dob']?.toString() ?? '',
      nationality: json['nationality']?.toString() ?? '',
      statusFamily: json['family_status']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      pob: json['pob']?.toString() ?? '',
      currentAddress: json['current_address']?.toString() ?? '',
      job: json['occupation']?.toString() ?? '',
      fatherName: json['father_name']?.toString() ?? '',
      motherName: json['mother_name']?.toString() ?? '',
      profileAvatar: json['profile_image_url']?.toString() ?? '',
      classId: json['class_id']?.toString() ?? '',
    );
  }

  final String id;
  final String studentId;
  final String email;
  final String nameKh;
  final String nameEn;
  final String gender;
  final String dob;
  final String nationality;
  final String statusFamily;
  final String phone;
  final String pob;
  final String currentAddress;
  final String job;
  final String fatherName;
  final String motherName;
  final String profileAvatar;
  final String classId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'email': email,
      'name_kh': nameKh,
      'name_en': nameEn,
      'gender': gender,
      'dob': dob,
      'nationality': nationality,
      'family_status': statusFamily,
      'phone': phone,
      'pob': pob,
      'current_address': currentAddress,
      'occupation': job,
      'father_name': fatherName,
      'mother_name': motherName,
      'profile_avatar': profileAvatar,
      'class_id': classId,
    };
  }
}
