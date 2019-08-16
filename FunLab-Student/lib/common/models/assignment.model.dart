import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_list_view.dart';
import 'package:funlab/student/pages/student_activity_detail.dart';

class Activity implements Listable {
  final String title;
  final int labSessionId;

  Activity({this.title, this.labSessionId});

  @override
  Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'] as String,
      labSessionId: json['lab_session_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'lab_session_id': labSessionId,
      };

  @override
  Widget buildListTile(BuildContext context) {
    return ListTile(title: Text('Activity title: $title'), 
                    subtitle: Text('Belongs to Session: $labSessionId'),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentActivityDetail(activity: this,)),
                      );
                    },);
  }
}
