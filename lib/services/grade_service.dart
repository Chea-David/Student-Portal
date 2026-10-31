import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_backend/database/mongodb.dart';
import 'package:my_backend/models/grade_model.dart';

class GradeService {
  Future<List<SemesterGrade>> getStudentGrades(String userId) async {
    final db = await MongoDatabase.getConnection();
    final studentCollection = db.collection('students'); 

    try {
      final userData = await studentCollection.findOne(
        where.id(ObjectId.fromHexString(userId)),
      );

      if (userData != null && userData['grades'] != null) {
        final list = userData['grades'] as List;
    
        return list.map((item) => SemesterGrade.fromJson(item as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      print('Error in GradeService: $e');
      return [];
    }
  }
}
