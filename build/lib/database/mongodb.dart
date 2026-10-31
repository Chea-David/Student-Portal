
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static Db? _db;

  static Future<Db> getConnection() async {
    if (_db == null || !_db!.isConnected) {
      final mongoUrl = Platform.environment['MONGODB_URI'] ?? 'mongodb://127.0.0.1:27017/RuppStudentPortal';
      _db = await Db.create(mongoUrl);
      await _db!.open();
    }
    return _db!;
  }
}