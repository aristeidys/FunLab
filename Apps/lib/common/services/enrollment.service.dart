import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EnrollmentService {
  String endpoint = Config.host + 'classrooms';

  Future<List<Enrollment>> getAll(int classroomID) async {
    final response = await http.get(endpoint + '/$classroomID/enrollments');
    return responseFromJson(response);
  }

  Future<List<User>> getAllActive(int classroomID) async {
    final response =
        await http.get(endpoint + '/$classroomID/enrollments/active');
    return responseUsersFromJson(response);
  }

  Future<List<User>> getAllPending(int classroomID) async {
    final response =
        await http.get(endpoint + '/$classroomID/enrollments/pending');
    return responseUsersFromJson(response);
  }

  Future<http.Response> setActive(Enrollment enrollment) async {
    enrollment.isActive = true;
    final response = await http.put(
        endpoint + '/${enrollment.classroomID}/students/${enrollment.studentID}/enrollment',
        headers: Config.headers,
        body: enrollmentToJson(enrollment));
    return response;
  }

  Future<http.Response> delete(Enrollment enrollment) async {
    final response = await http.delete(
        endpoint + '/${enrollment.classroomID}/students/${enrollment.studentID}/enrollment',
        headers: Config.headers);
    return response;
  }

  Future<http.Response> create(Enrollment enrollment) async {
    final response = await http.post(
        endpoint + '/${enrollment.classroomID}/enrollments',
        headers: Config.headers,
        body: enrollmentToJson(enrollment));
    return response;
  }

  List<User> responseUsersFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<User> users = allUsersFromJson(response.body);
      if (users.length == 0) {
        return List<User>();
      } else {
        return users;
      }
    } else {
      return List<User>();
    }
  }

  List<Enrollment> responseFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<Enrollment> classrooms = allEnrollmentsFromJson(response.body);
      if (classrooms.length == 0) {
        return List<Enrollment>();
      } else {
        return classrooms;
      }
    } else {
      return List<Enrollment>();
    }
  }
}
