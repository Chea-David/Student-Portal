class NotificationModel {
  NotificationModel({
    required this.id,
    required this.departmentName,
    required this.title,
    required this.detailImageUrl,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'].toString(),
      departmentName: json['department_name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      detailImageUrl: json['detail_image_url']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  final String id;
  final String departmentName;
  final String title;
  final String detailImageUrl;
  final String createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department_name': departmentName,
      'title': title,
      'detail_image_url': detailImageUrl,
      'created_at': createdAt,
    };
  }
}
