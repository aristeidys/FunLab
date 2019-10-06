import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SessionService {

  String endpoint = Config.host + 'sessions';

  Future<List<Session>> getAllSession() async {
    final response = await http.get(endpoint);
    print(response.body);
    return allSessionsFromJson(response.body);
  }

  Future<Session> getSession() async{
    final response = await http.get('$endpoint/1');
    return sessionFromJson(response.body);
  }

  Future<Session> getSessionBySessionname(String username) async{
    final response = await http.get('$endpoint?usename=$username');
    return sessionFromJson(response.body);
  }

  Future<http.Response> createSession(Session post) async{
    final response = await http.post('$endpoint',
        headers: Config.headers,
        body: sessionToJson(post)
    );
    return response;
  }
}