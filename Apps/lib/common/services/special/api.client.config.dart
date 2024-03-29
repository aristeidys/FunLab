import 'dart:io';

import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;

class Config {
  static String host = 'http://10.0.2.2:3000/';

  static final postSuccess = 201;
  static final getSuccess = 200; // GET
  static final putSuccess = 200; // PUT
  static final deleteSuccess = 204;
  static final notFound = 404; // DELETE

  static final unauthorized = 401;
  
  static String getSessionResultsPath(int studentsId) {
    return Config.host + 'students/$studentsId/session_results';
  }

  static String getClassroomsPath(int instructorsId) {
    return Config.host + 'instructors/$instructorsId/classrooms';
  }

  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: ''
  };

  static Response<int> idFromCreateJson(http.Response response) {
    if (response.statusCode == Config.postSuccess) {
      Classroom classroom = classroomFromJson(response.body);
      return Response(classroom.id, null);
    } else {
      return Response(null, response.body);
    }
  }

    static Response<Session> sessionFromPutJson(http.Response response) {
    if (response.statusCode == Config.putSuccess) {
      Session session = sessionFromJson(response.body);
      return Response(session, null);
    } else {
      return Response(null, response.body);
    }
  }

  static Response<int> idFromPutJson(http.Response response) {
    if (response.statusCode == Config.putSuccess) {
      Classroom classroom = classroomFromJson(response.body);
      return Response(classroom.id, null);
    } else {
      return Response(null, response.body);
    }
  }

  static Response<bool> idFromDeleteJson(http.Response response) {
    if (response.statusCode == Config.deleteSuccess) {
      return Response(true, null);
    } else {
      return Response(null, response.body);
    }
  }
}
