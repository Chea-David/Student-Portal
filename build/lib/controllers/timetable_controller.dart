import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/timetable_service.dart'; 

class TimetableController {
  final TimetableService _timetableService = TimetableService();

  Future<Response> getClassTimetable(String classId) async {
    try {
      
      final classTimetable = await _timetableService.getClassTimetable(classId);

      if (classTimetable == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: {'message': 'No timetable found'},
        );
      }

      return Response.json(body: classTimetable.toJson());
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Internal Server Error: $e'},
      );
    }
  }
}
