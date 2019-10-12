import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TaskResultService {
  String endpoint = Config.host + 'task_results';

  Future<http.Response> edit(TaskResult taskResult) async {
    final response = await http.put(endpoint,
        headers: Config.headers, body: taskResultToJson(taskResult));
    return response;
  }

  Future<List<TaskResult>> get(int studentID, int sessionID) async {
    final response = await http.get(
        endpoint + '?session_id=$sessionID&student_id=$studentID',
        headers: Config.headers);
    return responseTaskResultssFromJson(response);
  }

  List<TaskResult> responseTaskResultssFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<TaskResult> tasks = allTaskResultsFromJson(response.body);
      if (tasks.length == 0) {
        return List<TaskResult>();
      } else {
        return tasks;
      }
    } else {
      return List<TaskResult>();
    }
  }
}
