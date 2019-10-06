import 'dart:convert';

import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/services/special/base.service.dart';
import 'package:http/http.dart' as http;

class TaskService extends HttpService<Task> {
  
  @override
  final endpoint = '/activities/';

  Future<List<Task>> getAllTasks() async {
    final response = await http.Client().get(new Uri(scheme: scheme, host: url, port: port, path: endpoint));

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<Task>((json) => Task().fromJson(json))
        .toList();
  }

  Future<List<Task>> getTasksWithSessionID(int sessionId) async {
    final response = await http.Client().get(new Uri(scheme: scheme, host: url, port: port, path: '/lab_sessions/' + '$sessionId' + endpoint));
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<Task>((json) => Task().fromJson(json))
        .toList();
  }
}
