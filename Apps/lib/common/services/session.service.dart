import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SessionService {

  String endpoint = Config.host + 'sessions';

  Future<List<Session>> getAll() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allSessionsFromJson(response.body);
  }

  Future<Session> getByName(String name) async{
    final response = await http.get('$endpoint?name=$name');
    return sessionFromJson(response.body);
  }

  Future<http.Response> create(Session post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: sessionToJson(post)
    );
    return response;
  }
}