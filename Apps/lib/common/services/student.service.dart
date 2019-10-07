import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Response<T> {
  T data;
  String error;

  Response(this.data, this.error);
}

class StudentService {
  String endpoint = Config.host + 'students';

  Future<List<User>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allUsersFromJson(response.body);
  }

  Future<Response<User>> getByUsername(String username) async {
    final response = await http.get('$endpoint?username=$username');

    if (response.statusCode == 200) {
      List<User> users = allUsersFromJson(response.body);
      if (users.length == 0) {
        return Response(null, 'No Students found');
      } else {
        return Response(users[0], null);
      }
    } else {
      return Response(null, response.body);
    }
  }

  Future<http.Response> create(User post) async {
    final response = await http.post('$endpoint',
        headers: Config.headers, body: userToJson(post));
    return response;
  }
}
