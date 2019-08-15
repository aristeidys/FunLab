import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/widgets/custom_future_list.dart';

class StudentActivityList extends StatelessWidget {

  final int sessionIndex;

  StudentActivityList({Key key, @required this.sessionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student'),
        ),
        body: CustomFutureList<Activity>(ActivityService().getActivitiesWithSessionID(sessionIndex))
        );
  }
}
