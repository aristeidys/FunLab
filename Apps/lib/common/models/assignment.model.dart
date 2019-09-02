import 'package:funlab/common/widgets/custom_list_view.dart';

class Activity implements Listable {
  final String title;
  final int labSessionId;
  final int id;

  Activity({this.title, this.labSessionId, this.id});

  @override
  Activity fromJson(Map<String, dynamic> json) {
    return Activity(
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
