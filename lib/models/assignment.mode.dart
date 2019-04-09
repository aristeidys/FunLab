import 'package:flutter/material.dart';
import 'package:funlab/widgets/custom_list_view.dart';

class Activity implements Listable {
  final String title;
  final int id;

  Activity({this.title, this.id});

  @override
  Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'] as String,
      id: json['lab_session_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'lab_session_id': id,
      };

  @override
  Widget buildListTile() {
    return ListTile(title: Text('$title'), subtitle: Text('$id'));
  }
}
