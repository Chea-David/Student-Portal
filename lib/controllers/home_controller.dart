import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:my_backend/services/home_service.dart'; 

class HomeController {
  final HomeService _homeService = HomeService();

  Future<Response> getHomeDashboard(String id) async {
    try {
      
      final now = DateTime.now();
      final dayOfWeekNumber = now.weekday; 

      String currentDayKh;
      switch (dayOfWeekNumber) {
        case 1: currentDayKh = 'ចន្ទ'; break;
        case 2: currentDayKh = 'អង្គារ'; break;
        case 3: currentDayKh = 'ពុធ'; break;
        case 4: currentDayKh = 'ព្រហ.'; break;
        case 5: currentDayKh = 'សុក្រ'; break;
        case 6: currentDayKh = 'សៅរ៍'; break;
        default: currentDayKh = 'អាទិត្យ';
      }

      final dashboardData = await _homeService.getHomeDashboardData(id, currentDayKh);

      if (dashboardData == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: {'message': 'Unable to retrieve data for the home screen'},
        );
      }

      return Response.json(body: dashboardData);
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'message': 'Internal Server Error: $e'},
      );
    }
  }
}
