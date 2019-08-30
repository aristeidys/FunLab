import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/services/base.service.dart';
import 'package:http/http.dart' as http;

class StudentService extends HttpService<Student> {
  @override
  final endpoint = '/students/';

  Future<List<Student>> getStudentsByName(
          BuildContext context, String name) async =>
      await http.Client()
          .get(new Uri(
              scheme: scheme,
              host: url,
              port: port,
              queryParameters: {'name': name},
              path: endpoint))
          .then((response) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Student>((json) => Student().fromJson(json)).toList();
      });
}
