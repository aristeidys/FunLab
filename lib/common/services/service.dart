import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/widgets/custom_list_view.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class HttpService<T extends Listable> {
  final scheme = 'http';
  final url = '10.0.2.2';
  final endpoint = '/lab_sessions/';
  final headers = {"Content-Type": "application/json"};

  static final postSuccess = 201;
  static final success = 200; // PUT, GET
  static final deleteSuccess = 204;
  static final notFound = 404; // DELETE, GET, PUT

  Future<List<LabSession>> getAllLabSessions(BuildContext context) async =>
      await http.Client().get(new Uri(scheme: scheme, host: url, port: 3000, path: endpoint)).then((response) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<LabSession>((json) => LabSession().fromJson(json))
            .toList();
      }).catchError((e) {
        print("Got error: $e");
        if (e is SocketException) {
          ServerErrorToaster().show(context);
        } else {
          NoInternetToaster().show(context);
        }
      });

  Future<CustomResponse> getOne(int id) async {
    final response = await http.Client().get(Uri(scheme: scheme, host: url, port: 3000, path: endpoint));

    bool isSuccessful =
        response.statusCode == HttpService.success ? true : false;

    T payload = (T as Listable).fromJson(json.decode(response.body));

    return CustomResponse(payload, isSuccessful);
  }

  postRequest(T entity, ResponceCallback callback) async {
    final body = jsonEncode(entity);
    final response =
        await http.Client().post(new Uri(scheme: scheme, host: url, port: 3000, path: endpoint), headers: headers, body: body);

    bool isSuccessful = response.statusCode == postSuccess ? true : false;
    int newID = isSuccessful ? extractID(response) : -1;
    callback(isSuccessful, newID);
  }

  Future<CustomResponse> deleteRequest(int id) async {
    final response = await http.Client().delete(new Uri.http(url, endpoint + id.toString()));

    bool isSuccessful = response.statusCode == deleteSuccess ? true : false;

    return CustomResponse(0, isSuccessful);
  }

  Future<CustomResponse> putRequest(int id) async {
    final response = await http.Client().put(new Uri.http(url, endpoint));

    bool success = response.statusCode == HttpService.success ? true : false;

    return CustomResponse(0, success);
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

  CustomResponse(this.payload, this.success);
}

typedef void RequestFailureCallback();
typedef void ResponceCallback(bool success, int newID);
