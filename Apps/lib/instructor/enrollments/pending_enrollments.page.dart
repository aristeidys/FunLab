import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/enrollment.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

class PendingEnrollmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Pending Enrollments'),
              ),
              body: FutureBuilder<List<User>>(
                  future: EnrollmentService().getAllPending(classroom.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return new Center(
                        child: new CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              padding: const EdgeInsets.all(15.0),
                              itemBuilder: (context, position) {
                                User student = snapshot.data[position];
                                Enrollment enrollment = Enrollment(
                                    classroomID: classroom.id,
                                    studentID: student.id);
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: Container(
                                      color: Colors.white,
                                      child: StudentDefaultListTile(
                                          title: student.name,
                                          subTitle: student.email.toString())),
                                  actions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Reject',
                                        color: Colors.red,
                                        icon: Icons.assignment_turned_in,
                                        onTap: () async {
                                          EnrollmentService()
                                              .delete(enrollment);
                                        }),
                                  ],
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                      caption: 'Confirm',
                                      color: Colors.green,
                                      icon: Icons.assignment,
                                      onTap: () async {
                                        EnrollmentService()
                                            .setActive(enrollment);
                                      },
                                    ),
                                  ],
                                );
                              })
                          : Center(child: CircularProgressIndicator());
                    }
                  }));
        });
  }
}
