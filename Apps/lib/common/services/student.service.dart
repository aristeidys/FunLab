import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class StudentService {

  String endpoint = Config.host + 'students';

  Future<List<User>> getAllStudent() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allUsersFromJson(response.body);
  }

  Future<User> getStudent() async{
    final response = await http.get('$endpoint/1');
    return postFromJson(response.body);
  }

  Future<User> getStudentByUsername(String username) async{
    final response = await http.get('$endpoint?usename=$username');
    return postFromJson(response.body);
  }

  Future<http.Response> createStudent(User post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: postToJson(post)
    );
    return response;
  }
}