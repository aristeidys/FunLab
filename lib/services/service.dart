import 'package:funlab/models/lab_session.model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpService {

final url = 'http://localhost:3000';

  Future<List<LabSession>> getLabSessions() async {
    final response =
        await http.Client().get(url + '/lab_sessions');

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<LabSession>((json) => LabSession.fromJson(json)).toList();
  }

  void postLabSession(LabSession session) async {
    final body = jsonEncode(session);
    final response =
    await http.Client().post(url + '/lab_sessions', headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode != 201) {
      print('Could not Post LabSession');
    }
  }
}
