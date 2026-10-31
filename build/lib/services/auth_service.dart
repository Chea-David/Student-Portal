import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongodb.dart';
import '../models/student_model.dart';

class AuthService {
  Future<UserModel?> login(String email, String password) async {
    final db = await MongoDatabase.getConnection();
    final userCollection = db.collection('students');

    final userData = await userCollection.findOne(where.eq('email', email));

    if (userData != null && userData['password'] == password) {
      return UserModel.fromJson(userData);
    }
    
    return null; 
  }
}
