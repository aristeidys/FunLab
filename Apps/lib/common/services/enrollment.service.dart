import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EnrollmentService {
  String endpoint = Config.host + 'enrollments';

  Future<Response<int>> set(Enrollment enrollment) async {
    final response = await http.put(endpoint,
        headers: Config.headers, body: enrollmentToJson(enrollment));
    return Config.idFromPutJson(response);
  }

  Future<Response<bool>> delete(Enrollment enrollment) async {
    final response = await http.delete(endpoint, headers: Config.headers);
    return Config.idFromDeleteJson(response);
  }

  Future<Response<int>> create(Enrollment enrollment) async {
    final response = await http.post(endpoint,
        headers: Config.headers, body: enrollmentToJson(enrollment));
    return Config.idFromCreateJson(response);
  }
}
