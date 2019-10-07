import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EnrollmentService {
  String endpoint = Config.host + 'classrooms';

  Future<Response<List<Enrollment>>> getAll(int classroomID) async {
    final response = await http.get(Config.getEnrollmentsPath(classroomID));
    if (response.statusCode == 200) {
      List<Enrollment> classrooms = allEnrollmentsFromJson(response.body);
      if (classrooms.length == 0) {
        return Response(null, 'No Enrollments found');
      } else {
        return Response(classrooms, null);
      }
    } else {
      return Response(null, response.body);
    }
  }

  Future<http.Response> create(Enrollment enrollment) async {

    final response = await http.post(Config.getEnrollmentsPath(enrollment.classroomID),
        headers: Config.headers, body: enrollmentToJson(enrollment));    
    return response;
  }
}
