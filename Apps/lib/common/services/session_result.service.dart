import 'package:funlab/common/models/session_result.model.dart';
import 'package:funlab/common/services/special/api.client.config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SessionResultService {

  Future<http.Response> create(SessionResult sessionResult, int studentsId) async{
    final response = await http.post(Config.getSessionResultsPath(studentsId),
        headers: Config.headers,
        body: sessionResultToJson(sessionResult)
    );
    return response;
  }
}