import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class StudentService {
  String endpoint = Config.host + 'students';

  Future<List<Classroom>> getClassrooms(User student) async {
    final response = await http.get('$endpoint/${student.id}/classrooms');
    return responseClassroomsFromJson(response);
  }

  Future<Response<User>> getByEmail(String email) async {
    final response = await http.get('$endpoint?email=$email');

    if (response.statusCode == 200) {
      List<User> users = allUsersFromJson(response.body);
      if (users.length == 0) {
        return Response(null, 'No Students found');
      } else {
        return Response(users[0], null);
      }
    } else {
      return Response(null, response.body);
    }
  }

  Future<http.Response> create(User post) async {
    final response = await http.post('$endpoint',
        headers: Config.headers, body: userToJson(post));
    return response;
  }

  List<Classroom> responseClassroomsFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<Classroom> users = allClassroomsFromJson(response.body);
      if (users.length == 0) {
        return List<Classroom>();
      } else {
        return users;
      }
    } else {
      return List<Classroom>();
    }
  }
}
