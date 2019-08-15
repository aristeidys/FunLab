import 'dart:convert';

import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:http/http.dart' as http;

class ActivityService extends HttpService {
  
  @override
  final endpoint = '/activities/';

  createActivity(Activity entity, ResponceCallback callback) {
    postRequest(entity, callback);
  }

  Future<List<Activity>> getAllActivities() async {
    final response = await http.Client().get(new Uri(scheme: scheme, host: url, port: 3000, path: endpoint));

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<Activity>((json) => Activity().fromJson(json))
        .toList();
  }

  Future<List<Activity>> getActivitiesWithSessionID(int sessionId) async {
    final response = await http.Client().get(new Uri(scheme: scheme, queryParameters: {'lab_session_id': '$sessionId'}, host: url, port: 3000, path: endpoint));
  print('inside the http call $sessionId');
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<Activity>((json) => Activity().fromJson(json))
        .toList();
  }
}