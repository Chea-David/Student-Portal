
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_backend/database/mongodb.dart';
import 'package:my_backend/models/student_model.dart'; 
//import 'package:my_backend/models/class_model.dart';
import 'package:my_backend/models/notification_model.dart';

class HomeService {
  Future<Map<String, dynamic>?> getHomeDashboardData(String userId, String currentDayKh) async {
    final db = await MongoDatabase.getConnection();

    try {
      
      final userData = await db.collection('students').findOne(
        where.id(ObjectId.fromHexString(userId)),
      );
      
      if (userData == null) {
        print('Data for this User ID could not be found: $userId');
        return null;
      }
      
      final user = UserModel.fromJson(userData);

      List<dynamic> todaySchedules = [];
      if (userData['class_id'] != null) {
        
        final classObjectId = userData['class_id'] as ObjectId;

        final classData = await db.collection('classes').findOne(
          where.id(classObjectId),
        );
        
        if (classData != null && classData['weekly_timetable'] != null) {
          final timetable = classData['weekly_timetable'] as List;
          
          final todayData = timetable.firstWhere(
            (element) => element['day_of_week'] == currentDayKh,
            orElse: () => null,
          );
          if (todayData != null) {
            todaySchedules = todayData['schedules'] as List? ?? [];
          }
        }
      }

      final noticeData = await db.collection('notifications')
          .find(where.sortBy('created_at', descending: true).limit(2))
          .toList();
      final notifications = noticeData.map((item) => NotificationModel.fromJson(item)).toList();

      return {
        'student_name': user.nameEn,
        'student_id': user.studentId,
        'avatar': user.profileAvatar,
        'gpa': userData['gpa'] ?? { 'year_1': 0.0, 'year_2': 0.0, 'year_3': 0.0, 'year_4': null },
        'today_timetable': todaySchedules,
        'latest_notifications': notifications.map((e) => e.toJson()).toList(),
      };
      
    } catch (e, stackTrace) {
      print('Error HomeService: $e');
      print('Crash location: $stackTrace');
      return null;
    }
  }
}
