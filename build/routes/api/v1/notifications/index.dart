import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/controllers/notification_controller.dart'; 

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return NotificationController().getAllNotifications();
}

