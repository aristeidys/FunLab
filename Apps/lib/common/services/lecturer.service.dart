import 'package:funlab/common/models/user.model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endpoint = 'http://10.0.2.2:3000/instructors';

class InstructorService {

  Future<List<User>> getAllInstructor() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allUsersFromJson(response.body);
  }

  Future<User> getInstructor() async{
    final response = await http.get('$endpoint/1');
    return postFromJson(response.body);
  }

  Future<http.Response> createInstructor(User post) async{
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