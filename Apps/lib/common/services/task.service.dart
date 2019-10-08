import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:http/http.dart' as http;

class TaskService {
  String endpoint = Config.host + 'sessions';

  Future<List<Task>> getTasks(int sessionID) async {
    final response = await http.get('$endpoint/$sessionID/tasks');
    return responseTasksFromJson(response);
  }

  Future<Response<int>> create(Task task) async {
    final response = await http.post('$endpoint/${task.sessionID}/tasks',
        headers: Config.headers, body: taskToJson(task));
    return Config.idFromCreateJson(response);
  }

  List<Task> responseTasksFromJson(http.Response response) {
    if (response.statusCode == 200) {
      List<Task> tasks = allTasksFromJson(response.body);
      if (tasks.length == 0) {
        return List<Task>();
      } else {
        return tasks;
      }
    } else {
      return List<Task>();
    }
  }
}
