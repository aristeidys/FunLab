import 'package:funlab/common/models/session_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SessionResultService {

  Future<List<SessionResult>> getAll(int studentsId) async {
    final response = await http.get(Config.getSessionResultsPath(studentsId));
    print(response.body);
    return allSessionResultsFromJson(response.body);
  }

  Future<http.Response> create(SessionResult sessionResult, int studentsId) async{
    final response = await http.post(Config.getSessionResultsPath(studentsId),
        headers: Config.headers,
        body: sessionResultToJson(sessionResult)
    );
    return response;
  }
}