import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongodb.dart';
import '../models/notification_model.dart';

class NotificationService {
  
  Future<List<NotificationModel>> getAllNotifications() async {
    final db = await MongoDatabase.getConnection();
    final notificationCollection = db.collection('notifications');
    try {
      final list = await notificationCollection.find().toList();
      return list.map((item) => NotificationModel.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<NotificationModel?> getNotificationDetail(String id) async {
    final db = await MongoDatabase.getConnection();
    final notificationCollection = db.collection('notifications');

    try {
      
      final item = await notificationCollection.findOne(
        where.eq('_id', ObjectId.fromHexString(id)),
      );

      if (item != null) {
        return NotificationModel.fromJson(item);
      }
      return null;
    } catch (e) {
      print('Error in getNotificationDetail: $e');
      return null;
    }
  }
}
