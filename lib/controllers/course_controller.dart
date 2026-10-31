import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/course_service.dart'; 

class CourseController {
  final CourseService _courseService = CourseService();

  Future<Response> getAllCourses() async {
    final courses = await _courseService.getAllCourses();
    return Response.json(body: courses.map((e) => e.toJson()).toList());
  }

  Future<Response> getCourseDetail(String id) async {
    try {
      final course = await _courseService.getCourseDetail(id);

      if (course == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: {'message': 'This course could not be found.'},
        );
      }

      return Response.json(body: course.toJson());
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Server error: $e'},
      );
    }
  }

  Future<Response> enrollCourse(RequestContext context) async {
    try {
      final body = await context.request.body();
      final data = jsonDecode(body) as Map<String, dynamic>;

      final result = await _courseService.enrollCourse(
        studentId: data['student_id'] as String,
        courseId: data['course_id'] as String,
        days: data['days'] as String,
        timeSlot: data['time_slot'] as String,
        transactionId: data['transaction_id'] as String,
        amountPaid: (data['amount_paid'] as num).toDouble(),
      );

      if (result == 'duplicate') {
        return Response.json(
          statusCode: HttpStatus.conflict, 
          body: {'message': 'You have already enrolled in this course.'},
        );
      } else if (result == 'success') {
        return Response.json(
          body: {'message': 'Registration and payment successful'},
        );
      } else {
        return Response.json(
          statusCode: HttpStatus.internalServerError, 
          body: {'message': 'Registration failed'},
        );
      }
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Server error: $e'},
      );
    }
  }
}
