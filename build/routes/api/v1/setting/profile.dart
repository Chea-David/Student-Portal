import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/controllers/setting_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final controller = SettingController();

  if (context.request.method == HttpMethod.get) {
    return controller.getProfile(context);
  }
  if (context.request.method == HttpMethod.put) {
    return controller.updateProfile(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}
