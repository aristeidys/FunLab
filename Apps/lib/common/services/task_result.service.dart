import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TaskResultService {
  String endpoint = Config.host + 'task_results';

  Future<http.Response> edit(TaskResult taskResult) async {
    final response = await http.put(endpoint,
        headers: Config.headers, body: taskResultToJson(taskResult));
    return response;
  }
}
