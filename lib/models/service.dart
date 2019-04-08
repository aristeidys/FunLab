import 'package:funlab/models/dataModel/lab_session.model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpService {
  List<LabSession> parseLabSessions(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<LabSession>((json) => LabSession.fromJson(json)).toList();
  }

  Future<List<LabSession>> fetchLabSessions() async {
    final response =
        await http.Client().get('http://localhost:3000/lab_sessions');

    // compute function to run parseLabSession in a separate isolate
    return parseLabSessions(response.body);
  }
}
