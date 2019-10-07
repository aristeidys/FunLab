import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ClassroomService {

  String endpoint = Config.host + 'classrooms';

  Future<List<Classroom>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allClassroomsFromJson(response.body);
  }

    Future<Response<Classroom>> getByName(String name) async {
    final response = await http.get('$endpoint?name=$name');
    return responseFromJson(response);
  }

    Response<Classroom> responseFromJson(http.Response response) {
      if (response.statusCode == 200) {
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

  Future<http.Response> create(Classroom classroom, int instructorID) async{
    final response = await http.post(Config.getClassroomsPath(instructorID),
        headers: Config.headers,
        body: classroomToJson(classroom)
    );
    return response;
  }
}