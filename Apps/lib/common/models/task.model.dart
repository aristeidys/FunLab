import 'package:funlab/common/widgets/custom_list_view.dart';

class Task implements Listable {
  final String title;
  final int labSessionId;
  final int id;

  Task({this.title, this.labSessionId, this.id});

  @override
  Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      labSessionId: json['lab_session_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'lab_session_id': labSessionId,
      };
}
