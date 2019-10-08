import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TaskResultService {

  Future<http.Response> create(TaskResult taskResult, int studentsId) async{
    final response = await http.post(Config.getTaskResultsPath(studentsId),
        headers: Config.headers,
        body: taskResultToJson(taskResult)
    );
    return response;
  }
}