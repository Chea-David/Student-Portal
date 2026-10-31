import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/setting_service.dart'; 

class SettingController {
  final SettingService _settingService = SettingService();

  Future<Response> getProfile(RequestContext context) async {
    try {
      final params = context.request.uri.queryParameters;
      final studentId = params['student_id']?.toString() ?? '';

      if (studentId.isEmpty) {
        return Response.json(statusCode: HttpStatus.badRequest, body: {'message': 'student_id is required'});
      }

      final profile = await _settingService.getStudentProfile(studentId);
      if (profile == null) {
        return Response.json(statusCode: HttpStatus.notFound, body: {'message': 'Student not found.'});
      }
      return Response.json(body: profile.toJson());
    } catch (e) {
      return Response.json(statusCode: HttpStatus.internalServerError, body: {'message': '$e'});
    }
  }

  Future<Response> updateProfile(RequestContext context) async {
    try {
      final body = await context.request.json() as Map<String, dynamic>;
      final studentId = body['student_id']?.toString() ?? '';

      final isUpdated = await _settingService.updateFullProfile(
        userId: studentId,
        phone: body['phone']?.toString() ?? '',
        currentAddress: body['current_address']?.toString() ?? '',
        familyStatus: body['family_status']?.toString() ?? '',
        occupation: body['occupation']?.toString() ?? '',
        fatherName: body['father_name']?.toString() ?? '',
        motherName: body['mother_name']?.toString() ?? '',
      );
      return Response.json(body: {'success': isUpdated});
    } catch (e) {
      return Response.json(statusCode: HttpStatus.internalServerError, body: {'message': '$e'});
    }
  }

  Future<Response> changePassword(RequestContext context) async {
    try {
      final body = await context.request.json() as Map<String, dynamic>;
      final studentId = body['student_id']?.toString() ?? '';

      final result = await _settingService.changePassword(
        userId: studentId,
        oldPassword: body['old_password']?.toString() ?? '',
        newPassword: body['new_password']?.toString() ?? '',
        confirmPassword: body['confirm_password']?.toString() ?? '',
      );

      if (result == 'success') {
        return Response.json(body: {'success': true, 'message': 'Password changed successfully'});
      }
      return Response.json(statusCode: HttpStatus.badRequest, body: {'success': false, 'message': result});
    } catch (e) {
      return Response.json(statusCode: HttpStatus.internalServerError, body: {'message': '$e'});
    }
  }
}
