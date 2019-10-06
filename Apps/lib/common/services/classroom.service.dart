import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/services/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class ClassroomService {

  String endpoint = Config.host + 'classrooms';

  Future<List<Classroom>> getAllClassrooms() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allClassroomsFromJson(response.body);
  }

  Future<Classroom> getClassroom() async{
    final response = await http.get('$endpoint/1');
    return postFromJson(response.body);
  }

  Future<http.Response> createClassroom(Classroom post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: postToJson(post)
    );
    return response;
  }
}