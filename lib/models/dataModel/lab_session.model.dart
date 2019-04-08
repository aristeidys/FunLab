import 'package:flutter/material.dart';
import 'package:funlab/widgets/custom_list_view.dart';

class LabSession implements Listable {
  final String title;
  final bool finished;

  LabSession({this.title, this.finished});

  factory LabSession.fromJson(Map<String, dynamic> json) {
    return LabSession(
      title: json['title'] as String,
      finished: json['finished'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'finished': finished,
      };

  @override
  Widget buildListTile() {
    return ListTile(title: Text('$title'), subtitle: Text('$finished'));
  }
}
