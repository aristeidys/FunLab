import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EnrollmentService {
  String endpoint = Config.host + 'classrooms';

  Future<List<User>> getAllApproved(int classroomID) async {
    final response =
        await http.get(endpoint + '/$classroomID/enrollments?isApproved=true');
    return User.responseUsersFromJson(response);
  }

  Future<List<User>> getAllPending(int classroomID) async {
    final response =
        await http.get(endpoint + '/$classroomID/enrollments?isApproved=false');
    return User.responseUsersFromJson(response);
  }

  Future<Response<int>> setActive(Enrollment enrollment) async {
    enrollment.isApproved = true;
    final response = await http.put(
        endpoint +
            '/${enrollment.classroomID}/students/${enrollment.studentID}/enrollment',
        headers: Config.headers,
        body: enrollmentToJson(enrollment));
    return Config.idFromPutJson(response);
  }

  Future<Response<bool>> delete(Enrollment enrollment) async {
    final response = await http.delete(
        endpoint +
            '/${enrollment.classroomID}/students/${enrollment.studentID}/enrollment',
        headers: Config.headers);
    return Config.idFromDeleteJson(response);
  }

  Future<Response<int>> create(Enrollment enrollment) async {
    final response = await http.post(
        endpoint + '/${enrollment.classroomID}/enrollments',
        headers: Config.headers,
        body: enrollmentToJson(enrollment));
    return Config.idFromCreateJson(response);
  }
}
