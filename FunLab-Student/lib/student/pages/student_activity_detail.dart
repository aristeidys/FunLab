import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/widgets/custom_future_list.dart';

class StudentActivityDetail extends StatelessWidget {

  final Activity activity;

  StudentActivityDetail({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${activity.title}'),
        ),
        body: Text('Activity title: ${activity.title}')
        );
  }
}