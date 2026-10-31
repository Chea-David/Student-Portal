import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/controllers/setting_controller.dart'; 

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return SettingController().changePassword(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}
