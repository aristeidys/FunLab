import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_list_view.dart';

class LabSession implements Listable {
  final String title;
  final bool finished;
  int id;

  LabSession({this.title, this.finished, this.id});

  @override
  LabSession fromJson(Map<String, dynamic> json) {
    return LabSession(
      title: json['title'] as String,
      finished: json['finished'] as bool,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'finished': finished,
        'id': id
      };

  @override
  Widget buildListTile() {
    return ListTile(title: Text('$title'), subtitle: Text('$finished'));
  }
}
