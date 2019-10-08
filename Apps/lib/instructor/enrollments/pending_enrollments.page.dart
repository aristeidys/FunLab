import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/enrollment.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

class PendingEnrollmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Pending Enrollments'),
              ),
              body: PendingEnrollmentWidget(classroom.id));
        });
  }
}

class PendingEnrollmentWidget extends StatefulWidget {
  final int classroomID;

  PendingEnrollmentWidget(this.classroomID);

  @override
  PendingEnrollmentWidgetState createState() => PendingEnrollmentWidgetState();
}

class PendingEnrollmentWidgetState extends State<PendingEnrollmentWidget> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    EnrollmentService().getAllPending(widget.classroomID).then((fetchedUsers) {
      setState(() {
        users = fetchedUsers;
      });
    });
  }

  void removeAtIndex(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      users.length == 0
          ? Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text('Student pending enrollments will appear here'),
              ))
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    User student = users[index];
                    Enrollment enrollment = Enrollment(
                        classroomID: widget.classroomID, studentID: student.id);
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
                              handleReject(enrollment, student, index, context);
                            }),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Confirm',
                          color: Colors.green,
                          icon: Icons.assignment,
                          onTap: () async {
                            handleConfirm(enrollment, student, index, context);
                          },
                        ),
                      ],
                    );
                  }))
    ]);
  }

  void handleConfirm(
      Enrollment enrollment, User student, int index, BuildContext context) {
    EnrollmentService().setActive(enrollment).then((response) {
      if (response.data != null) {
        removeAtIndex(index);
        CustomToaster().showToast(context, ToasterType.success,
            'Successfully confirmed ${student.name}');
      } else {
        CustomToaster().showToast(
            context, ToasterType.success, 'Failed to confirm Enrollment');
      }
    });
  }

  void handleReject(
      Enrollment enrollment, User student, int index, BuildContext context) {
    EnrollmentService().delete(enrollment).then((response) {
      if (response.data != null) {
        removeAtIndex(index);
        CustomToaster().showToast(context, ToasterType.success,
            'Successfully rejected ${student.name}');
      } else {
        CustomToaster().showToast(
            context, ToasterType.success, 'Failed to reject Enrollment');
      }
    });
  }
}
