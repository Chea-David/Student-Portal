import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongodb.dart';
import '../models/student_model.dart'; 

class SettingService {
  
  Future<UserModel?> getStudentProfile(String userId) async {
    final db = await MongoDatabase.getConnection();
    final studentCollection = db.collection('students');

    try {
      
      final studentData = await studentCollection.findOne(
        where.id(ObjectId.fromHexString(userId)),
      );

      if (studentData == null) return null;
      return UserModel.fromJson(studentData);
    } catch (e) {
      print('Error in getStudentProfile: $e');
      return null;
    }
  }

  Future<bool> updateFullProfile({
    required String userId,
    required String phone,
    required String currentAddress,
    required String familyStatus,
    required String occupation,
    required String fatherName,
    required String motherName,
  }) async {
    final db = await MongoDatabase.getConnection();
    final studentCollection = db.collection('students');

    try {
      final result = await studentCollection.updateOne(
        where.id(ObjectId.fromHexString(userId)),
        modify
            .set('phone', phone)
            .set('current_address', currentAddress)
            .set('family_status', familyStatus) 
            .set('occupation', occupation)       
            .set('father_name', fatherName)      
            .set('mother_name', motherName),      
      );
      return result.isSuccess;
    } catch (e) {
      print('Error in updateFullProfile: $e');
      return false;
    }
  }

  Future<String> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    
    if (newPassword != confirmPassword) {
      return 'The new password and the password confirmation do not match.';
    }

    final db = await MongoDatabase.getConnection();
    final studentCollection = db.collection('students');

    try {
    
      final student = await studentCollection.findOne(
        where.id(ObjectId.fromHexString(userId)),
      );
      
      if (student == null) return 'Student account not found';
      
      if (student['password'] != oldPassword) {
        return 'The old password is incorrect.';
      }

      final result = await studentCollection.updateOne(
        where.id(ObjectId.fromHexString(userId)),
        modify.set('password', newPassword),
      );

      return result.isSuccess ? 'success' : 'Password change failed';
    } catch (e) {
      print('Error in changePassword: $e');
      return 'Server error: $e';
    }
  }
}
