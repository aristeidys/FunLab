import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class InstructorService {

  String endpoint = Config.host + 'instructors';

  Future<List<User>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allUsersFromJson(response.body);
  }

  Future<Response<User>> getByEmail(String email) async {
    final response = await http.get('$endpoint?email=$email');

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

  Future<http.Response> create(User post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: userToJson(post)
    );
    return response;
  }
}