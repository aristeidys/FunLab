import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/widgets/custom_list_view.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpService<T extends Listable> {
  final url = 'http://localhost:3000';
  final endpoint = '/lab_sessions/';
  final headers = {"Content-Type": "application/json"};

  static final POST_SUCCESS = 201;
  static final SUCCESS = 200; // PUT, GET
  static final DELETE_SUCCESS = 204;
  static final NOTFOUND = 404; // DELETE, GET, PUT

  Future<List<LabSession>> getAllLabSessions() async {
    final response = await http.Client().get(url + endpoint);

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<LabSession>((json) => LabSession().fromJson(json)).toList();
  }

  Future<Response> getOne(int id) async {
    final response = await http.Client().get(url + endpoint);

    bool isSuccessful = response.statusCode == SUCCESS ? true : false;

    T payload = (T as Listable).fromJson(json.decode(response.body));

    return Response(payload, isSuccessful);
  }

  Future<Response> postRequest(T entity, ResponceCallback callback) async {
    final body = jsonEncode(entity);
    final response =
        await http.Client().post(url + endpoint, headers: headers, body: body);

    bool isSuccessful = response.statusCode == POST_SUCCESS ? true : false;
    callback(isSuccessful);
    
    return Response(0, isSuccessful);
  }

  Future<Response> deleteRequest(int id) async {
    final response = await http.Client().delete(url + endpoint + id.toString());

    bool isSuccessful = response.statusCode == DELETE_SUCCESS ? true : false;

    return Response(0, isSuccessful);
  }

  Future<Response> putRequest(int id) async {
    final response = await http.Client().put(url + endpoint);

    bool success = response.statusCode == SUCCESS ? true : false;

    return Response(0, success);
  }
}

class Response<T> {
  T payload;
  bool success;

  Response(this.payload, this.success);
}

class HttpCode {}

typedef void ResponceCallback(bool success);
