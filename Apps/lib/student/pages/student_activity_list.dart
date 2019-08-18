import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/widgets/custom_future_list.dart';

class StudentActivityList extends StatelessWidget {

  final LabSession labSession;

  StudentActivityList({Key key, @required this.labSession}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student: Inside Session ${labSession.title}'),
        ),
        body: CustomFutureList<Activity>(ActivityService().getActivitiesWithSessionID(labSession.id))
        );
  }
}