import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/base.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:http/http.dart' as http;

class LabSessionService extends HttpService<LabSession> {
  @override
  final endpoint = '/lab_sessions/';

  Future<List<LabSession>> getAllLabSessions(BuildContext context) async =>
      await http.Client()
          .get(new Uri(scheme: scheme, host: url, port: port, path: endpoint))
          .then((response) {
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

  Future<List<LabSession>> getLabSessionsWithTitle(
          BuildContext context, String title) async =>
      await http.Client()
          .get(new Uri(
              scheme: scheme,
              host: url,
              port: port,
              queryParameters: {'title': title},
              path: endpoint))
          .then((response) {
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
}
