// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/api/v1/timetables/[id].dart' as api_v1_timetables_$id;
import '../routes/api/v1/setting/profile.dart' as api_v1_setting_profile;
import '../routes/api/v1/setting/change-password.dart' as api_v1_setting_change_password;
import '../routes/api/v1/notifications/index.dart' as api_v1_notifications_index;
import '../routes/api/v1/notifications/[id].dart' as api_v1_notifications_$id;
import '../routes/api/v1/home/[id].dart' as api_v1_home_$id;
import '../routes/api/v1/grades/[id].dart' as api_v1_grades_$id;
import '../routes/api/v1/courses/index.dart' as api_v1_courses_index;
import '../routes/api/v1/courses/enroll.dart' as api_v1_courses_enroll;
import '../routes/api/v1/courses/[id].dart' as api_v1_courses_$id;
import '../routes/api/v1/auth/login.dart' as api_v1_auth_login;


void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/', (context) => buildHandler()(context))
    ..mount('/api/v1/timetables', (context) => buildApiV1TimetablesHandler()(context))
    ..mount('/api/v1/setting', (context) => buildApiV1SettingHandler()(context))
    ..mount('/api/v1/notifications', (context) => buildApiV1NotificationsHandler()(context))
    ..mount('/api/v1/home', (context) => buildApiV1HomeHandler()(context))
    ..mount('/api/v1/grades', (context) => buildApiV1GradesHandler()(context))
    ..mount('/api/v1/courses', (context) => buildApiV1CoursesHandler()(context))
    ..mount('/api/v1/auth', (context) => buildApiV1AuthHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1TimetablesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => api_v1_timetables_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiV1SettingHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/change-password', (context) => api_v1_setting_change_password.onRequest(context,))..all('/profile', (context) => api_v1_setting_profile.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1NotificationsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => api_v1_notifications_$id.onRequest(context,id,))..all('/', (context) => api_v1_notifications_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1HomeHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => api_v1_home_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiV1GradesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => api_v1_grades_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiV1CoursesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/enroll', (context) => api_v1_courses_enroll.onRequest(context,))..all('/<id>', (context,id,) => api_v1_courses_$id.onRequest(context,id,))..all('/', (context) => api_v1_courses_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1AuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/login', (context) => api_v1_auth_login.onRequest(context,));
  return pipeline.addHandler(router);
}

