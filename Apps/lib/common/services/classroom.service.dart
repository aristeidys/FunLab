import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ClassroomService {

  String endpoint = Config.host + 'classrooms';

  Future<List<Classroom>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allClassroomsFromJson(response.body);
  }

  Future<http.Response> create(Classroom classroom, int instructorID) async{
    final response = await http.post(Config.getClassroomsPath(instructorID),
        headers: Config.headers,
        body: classroomToJson(classroom)
    );
    return response;
  }
}