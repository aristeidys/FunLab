import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:funlab/student/pages/student_activity_detail.dart';

class StudentActivityList extends StatelessWidget {
  final LabSession labSession;

  StudentActivityList({Key key, @required this.labSession}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student: Inside Session ${labSession.title}'),
        ),
        body: FutureBuilder<List<Activity>>(
          future: ActivityService().getActivitiesWithSessionID(labSession.id),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, position) {
                      return ListTileWithArrow(
                        title: snapshot.data[position].title,
                        subTitle:
                            snapshot.data[position].labSessionId.toString(),
                        onTapCallback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentActivityDetail(
                                      activity: snapshot.data[position])));
                        },
                      );
                    })
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
