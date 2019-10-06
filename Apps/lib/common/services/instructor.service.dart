import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class InstructorService {

  String endpoint = Config.host + 'instructors';

  Future<List<User>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allUsersFromJson(response.body);
  }

  Future<User> getByUsername(String username) async{
    final response = await http.get('$endpoint?usename=$username');
    return userFromJson(response.body);
  }

  Future<http.Response> create(User post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: userToJson(post)
    );
    return response;
  }
}