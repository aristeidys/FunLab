import 'package:funlab/common/models/new_task.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class NewTaskService {

  Future<http.Response> create(NewTask task, int sessionID) async{
    final response = await http.post(Config.getTaskPath(sessionID),
        headers: Config.headers,
        body: taskToJson(task)
    );
    return response;
  }
}