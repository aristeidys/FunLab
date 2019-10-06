import 'package:funlab/common/models/classroom.model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endpoint = '10.0.2.2:3000/classrooms';

class LabSessionService {

  Future<List<Classroom>> getAllPosts() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allClassroomsFromJson(response.body);
  }

  Future<Classroom> getPost() async{
    final response = await http.get('$endpoint/1');
    return postFromJson(response.body);
  }

  Future<http.Response> createPost(Classroom post) async{
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