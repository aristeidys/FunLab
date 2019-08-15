import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_list_view.dart';

class LabSession implements Listable {
  final String title;
  final bool finished;
  final bool draft;
  int id;
  
  LabSession({this.title, this.finished, this.id, this.draft});

  @override
  LabSession fromJson(Map<String, dynamic> json) {
    return LabSession(
      title: json['title'] as String,
      finished: json['finished'] as bool,
      draft: json['draft'] as bool,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'finished': finished,
        'draft': draft,
        'id': id
      };

  @override
  Widget buildListTile() {
    return ListTile(title: Text('title: $title'), subtitle: Text('is draft: $draft'));
  }
}
