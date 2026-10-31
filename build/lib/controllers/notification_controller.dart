import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/notification_service.dart'; 

class NotificationController {
  final NotificationService _notificationService = NotificationService();

  Future<Response> getAllNotifications() async {
    try {
      final notifications = await _notificationService.getAllNotifications();
      return Response.json(body: notifications.map((e) => e.toJson()).toList());
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Internal Server Error: $e'},
      );
    }
  }

  Future<Response> getNotificationDetail(String id) async {
    try {
      final notification = await _notificationService.getNotificationDetail(id);

      if (notification == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: {'message': 'This notification could not be found'},
        );
      }

      return Response.json(body: notification.toJson());
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Server error: $e'},
      );
    }
  }
}
