import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongodb.dart';
import '../models/course_model.dart';

class CourseService {
 
  Future<List<CourseModel>> getAllCourses() async {
    final db = await MongoDatabase.getConnection();
    return db.collection('courses').find().map((item) => CourseModel.fromJson(item)).toList();
  }

   Future<String> enrollCourse({
    required String studentId,
    required String courseId,
    required String days,
    required String timeSlot,
    required String transactionId, 
    required double amountPaid,     
  }) async {
    final db = await MongoDatabase.getConnection();
    final registrationCollection = db.collection('enrollments');

    try {
      final sId = ObjectId.fromHexString(studentId);
      final cId = ObjectId.fromHexString(courseId);

      final alreadyEnrolled = await registrationCollection.findOne(
        where.eq('student_id', sId).and(where.eq('course_id', cId)),
      );

      if (alreadyEnrolled != null) {
        return 'duplicate'; 
      }

      final result = await registrationCollection.insertOne({
        'student_id': sId,
        'course_id': cId,
        'selected_schedule': {
          'days': days,
          'time_slot': timeSlot,
        },
        'payment_info': {
          'transaction_id': transactionId,
          'status': 'Completed',
          'amount_paid': amountPaid,
          'gateway': 'PayPal'
        },
        'enrolled_at': DateTime.now().toIso8601String(),
      });
      
      return result.isSuccess ? 'success' : 'failed';
    } catch (e) {
      return 'error';
    }
  }
  Future<CourseModel?> getCourseDetail(String id) async {
    final db = await MongoDatabase.getConnection();
    final courseCollection = db.collection('courses');

    try {
      
      final item = await courseCollection.findOne(
        where.eq('_id', ObjectId.fromHexString(id)),
      );

      if (item != null) {
        return CourseModel.fromJson(item);
      }
      return null;
    } catch (e) {
      print('Error in getCourseDetail: $e');
      return null;
    }
  }
}

