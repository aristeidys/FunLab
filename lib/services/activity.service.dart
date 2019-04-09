import 'dart:convert';

import 'package:funlab/models/assignment.model.dart';
import 'package:funlab/services/service.dart';
import 'package:http/http.dart' as http;

class ActivityService extends HttpService {
  
  @override
  final endpoint = '/activities/';

  createActivity(Activity entity, ResponceCallback callback) {
    postRequest(entity, callback);
  }

    Future<List<Activity>> getAllActivities() async {
    final response = await http.Client().get(url + endpoint);

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<Activity>((json) => Activity().fromJson(json))
        .toList();
  }
}
