import 'package:funlab/common/models/classroom.model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endpoint = 'http://10.0.2.2:3000/classrooms';

class ClassroomService {

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
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        },
        body: postToJson(post)
    );
    return response;
  }
}