import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;

class TaskService {
  String endpoint = Config.host + 'sessions';

  Future<List<TaskResult>> getTaskAndCreateTaskResultsIfNotExist(int sessionID, int studentID) async {
    final response = await http.get('$endpoint/$sessionID/tasks?student_id=$studentID');
    return responseTasksFromJson(response);
  }

  Future<Response<int>> create(Task task) async {
    final response = await http.post('$endpoint/${task.sessionID}/tasks',
        headers: Config.headers, body: taskToJson(task));
    return Config.idFromCreateJson(response);
  }

  List<TaskResult> responseTasksFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<TaskResult> tasks = allTasksResultsFromJson(response.body);
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
