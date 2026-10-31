import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/auth_service.dart'; 

class AuthController {
  final AuthService _authService = AuthService();

  Future<Response> login(RequestContext context) async {
    try {
 
      final body = await context.request.body();
      final data = jsonDecode(body) as Map<String, dynamic>;
      final email = data['email'] as String?;
      final password = data['password'] as String?;

      if (email == null || password == null) {
        return Response.json(
          statusCode: HttpStatus.badRequest, 
          body: {'message': 'Please fill in the information.'},
        );
      }

      final user = await _authService.login(email, password);

      if (user == null) {
        return Response.json(
          statusCode: HttpStatus.unauthorized, 
          body: {'message': 'Invalid account'},
        );
      }

      return Response.json(
        body: {
          'message': 'Success', 
          'user': user.toJson(),
        },
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Internal Server Error: $e'},
      );
    }
  }
}
