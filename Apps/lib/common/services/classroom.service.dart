import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ClassroomService {
  String endpoint = Config.host + 'classrooms';

  Future<Response<Classroom>> getByName(String name) async {
    final response = await http.get('$endpoint?name=$name');
    return Classroom.firstClassroomFromJson(response);
  }

  Future<Response<Classroom>> getByNameAndStudentID(String name, int studentID) async {
    final response = await http.get('$endpoint?name=$name&student_id=$studentID');
    return Classroom.firstClassroomFromJson(response);
  }

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

  Future<Response<List<Session>>> getAllActiveSessions(int classroomID) async {
    final response = await http.get(
        '$endpoint/$classroomID/sessions?status=active',
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
}
