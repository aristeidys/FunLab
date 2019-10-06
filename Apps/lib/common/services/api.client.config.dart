import 'dart:io';

class Config {
  static String host = 'http://10.0.2.2:3000/';

  static String getEnrollmentsPath(int classroomId) {
    return Config.host + 'classrooms/$classroomId/enrollments';
  }

  static String getSessionsPath(int classroomId) {
    return Config.host + 'classrooms/$classroomId/sessions';
  }

  static String getTaskPath(int sessionId) {
    return Config.host + 'sessions/$sessionId/tasks';
  }

  static String getTaskResultsPath(int studentsId) {
    return Config.host + 'students/$studentsId/task_results';
  }

  static String getSessionResultsPath(int studentsId) {
    return Config.host + 'students/$studentsId/session_results';
  }

  static String getClassroomsPath(int instructorsId) {
    return Config.host + 'instructors/$instructorsId/classrooms';
  }

  static Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        };
}
