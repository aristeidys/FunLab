import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class HttpService<T> {
  final scheme = 'http';
  final url = '10.0.2.2';
  final endpoint = '/';
  final headers = {"Content-Type": "application/json"};
  final port = 3000;

  static final postSuccess = 201;
  static final success = 200; // PUT, GET
  static final deleteSuccess = 204;
  static final notFound = 404; // DELETE, GET, PUT

  postRequest(T entity, ResponceCallback<int> callback) async {
    final body = jsonEncode(entity);
    final response = await http.Client().post(
        new Uri(scheme: scheme, host: url, port: port, path: endpoint),
        headers: headers,
        body: body);

    bool isSuccessful = response.statusCode == postSuccess ? true : false;
    int newID = isSuccessful ? extractID(response) : -1;
    callback(isSuccessful, newID, response.statusCode == 422 ? 'Name has already been taken' : '');
  }

  putRequest(T entity, int id, ResponceCallback<int> callback) async {
    final body = jsonEncode(entity);
    final response = await http.Client().put(
        new Uri(
            scheme: scheme,
            host: url,
            port: port,
            path: endpoint + id.toString()),
        headers: headers,
        body: body);

    bool isSuccessful = response.statusCode == success ? true : false;
    int newID = isSuccessful ? extractID(response) : -1;
    callback(isSuccessful, newID, '');
  }

  Future<CustomResponse> deleteRequest(int id) async {
    final response =
        await http.Client().delete(new Uri.http(url, endpoint + id.toString()));

    bool isSuccessful = response.statusCode == deleteSuccess ? true : false;

    return CustomResponse(0, isSuccessful, '');
  }

  int extractID(Response response) {
    String location = response.headers['location'];

    int index = location.lastIndexOf('/');

    String indexString = location.substring(index + 1, location.length);
    return int.parse(indexString);
  }
}

class CustomResponse<T> {
  T payload;
  bool success;
  String errorMessage;

  CustomResponse(this.payload, this.success, this.errorMessage);
}

class ErrorBody {
  List<String> name;
}

typedef void RequestFailureCallback();
typedef void ResponceCallback<T>(bool success, T payload, String errorMessage);