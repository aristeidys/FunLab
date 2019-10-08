import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ClassroomService {
  String endpoint = Config.host + 'classrooms';

  Future<Response<Classroom>> getByName(String name) async {
    final response = await http.get('$endpoint?name=$name');
    return firstClassroomFromJson(response);
  }

    Future<Response<List<Session>>> getAllActiveSessions(int classroomID) async {
    final response = await http.get('$endpoint/$classroomID/sessions?status=active',
        headers: Config.headers);
    return Session.sessionsResponseFromJson(response);
  }
    Future<Response<List<Session>>> getAllSessions(int classroomID) async {
    final response = await http.get('$endpoint/$classroomID/sessions',
        headers: Config.headers);
    return Session.sessionsResponseFromJson(response);
  }

  Future<Response<int>> create(Classroom classroom, int instructorID) async {
    final response = await http.post(Config.getClassroomsPath(instructorID),
        headers: Config.headers, body: classroomToJson(classroom));
    return Config.idFromCreateJson(response);
  }

  // Helper Methods  allSessionsFromJson

  Response<Classroom> firstClassroomFromJson(http.Response response) {
    if (response.statusCode == Config.getSuccess) {
      List<Classroom> classrooms = allClassroomsFromJson(response.body);
      if (classrooms.length == 0) {
        return Response(null, 'No Classrooms found');
      } else {
        return Response(classrooms[0], null);
      }
    } else {
      return Response(null, response.body);
    }
  }
}
