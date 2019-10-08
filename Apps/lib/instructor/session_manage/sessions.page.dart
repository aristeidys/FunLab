import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/stateManagment/reducers/session_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

class SessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return StoreConnector<AppInstructorState, OnStateChanged>(
              converter: (store) {
            return (session) => store.dispatch(SetSessionAction(session));
          }, builder: (context, callback) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Styles.instructorColor,
                  title: Text('All Sessions in ${classroom.name}'),
                ),
                body: AllSessionsList(classroom.id));
          });
        });
  }
}

class AllSessionsList extends StatefulWidget {
  final int classroomID;

  AllSessionsList(this.classroomID);

  @override
  AllSessionsListState createState() => AllSessionsListState();
}

class AllSessionsListState extends State<AllSessionsList> {
  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    ClassroomService().getAllSessions(widget.classroomID).then((response) {
      if (response.error == null) {
        setState(() {
          sessions = response.data;
        });
      } else {
        CustomToaster().showToast(context, ToasterType.success,
            'Failed to fetch Sessions ${response.error}');
      }
    });
  }

  void removeAtIndex(int index) {
    setState(() {
      sessions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      sessions.length == 0
          ? Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text('Sessions will appear here'),
              ))
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sessions.length,
                  itemBuilder: (BuildContext context, int index) {
                    Session session = sessions[index];
                    // Enrollment enrollment = Enrollment(
                    //     classroomID: widget.classroomID, studentID: session.id);
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                          color: Colors.white,
                          child: StudentDefaultListTile(
                              title: session.title, subTitle: session.status)),
                      actions: <Widget>[
                        // IconSlideAction(
                        //     caption: 'Reject',
                        //     color: Colors.red,
                        //     icon: Icons.assignment_turned_in,
                        //     onTap: () async {
                        //       handleReject(enrollment, session, index, context);
                        //     }),
                      ],
                      secondaryActions: <Widget>[
                        // IconSlideAction(
                        //   caption: 'Confirm',
                        //   color: Colors.green,
                        //   icon: Icons.assignment,
                        //   onTap: () async {
                        //     handleConfirm(enrollment, student, index, context);
                        //   },
                        // ),
                      ],
                    );
                  }))
    ]);
  }

  // void handleConfirm(
  //     Enrollment enrollment, User student, int index, BuildContext context) {
  //   EnrollmentService().setActive(enrollment).then((response) {
  //     if (response.data != null) {
  //       removeAtIndex(index);
  //       CustomToaster().showToast(context, ToasterType.success,
  //           'Successfully confirmed ${student.name}');
  //     } else {
  //       CustomToaster().showToast(
  //           context, ToasterType.success, 'Failed to confirm Enrollment');
  //     }
  //   });
  // }

  // void handleReject(
  //     Enrollment enrollment, User student, int index, BuildContext context) {
  //   EnrollmentService().delete(enrollment).then((response) {
  //     if (response.data != null) {
  //       removeAtIndex(index);
  //       CustomToaster().showToast(context, ToasterType.success,
  //           'Successfully rejected ${student.name}');
  //     } else {
  //       CustomToaster().showToast(
  //           context, ToasterType.success, 'Failed to reject Enrollment');
  //     }
  //   });
  // }
}
