import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SessionService {
  String endpoint = Config.host + 'sessions';

  Future<Session> getByName(String name) async {
    final response = await http.get('$endpoint?name=$name');
    return sessionFromJson(response.body);
  }

  Future<List<Task>> getTasks(int sessionID) async {
    final response =
        await http.get('$endpoint/$sessionID/tasks', headers: Config.headers);
    return Task.tasksResponseFromJson(response);
  }

  Future<Response<int>> create(Session session) async {
    final response = await http.post('$endpoint',
        headers: Config.headers, body: sessionToJson(session));
    return Config.idFromCreateJson(response);
  }

  Future<Response<Session>> put(Session session) async {
    final response = await http.put('$endpoint/${session.id}',
        headers: Config.headers, body: sessionToJson(session));
    return Config.sessionFromPutJson(response);
  }
}
