import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/grade_service.dart'; 

class GradeController {
  final GradeService _gradeService = GradeService();

  Future<Response> getStudentGrades(String id) async {
    try {
      
      final grades = await _gradeService.getStudentGrades(id);

      return Response.json(body: grades.map((e) => e.toJson()).toList());
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Internal Server Error: $e'},
      );
    }
  }
}
