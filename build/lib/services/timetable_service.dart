import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongodb.dart';
import '../models/class_model.dart';

class TimetableService {
  Future<ClassModel?> getClassTimetable(String classId) async {
    final db = await MongoDatabase.getConnection();
    final classCollection = db.collection('classes');

    try {
      final classData = await classCollection.findOne(
        where.id(ObjectId.fromHexString(classId)),
      );

      if (classData != null) {
        return ClassModel.fromJson(classData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
