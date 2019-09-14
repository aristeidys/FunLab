import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/student/components/find_lab_session_form.dart';
import 'package:funlab/student/pages/student_activity_list.dart';

class StudentSessionJoinPage extends StatefulWidget {
  @override
  _StudentSessionJoinPageState createState() =>
      _StudentSessionJoinPageState();
}

class _StudentSessionJoinPageState extends State<StudentSessionJoinPage> {
  final pageController = new PageController();

  final List<LabSession> sessions = [];
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Join a Session'),
        ),
        body: Column(children: <Widget>[
          FindLabSessionForm(buttonCallback: (LabSession session) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentActivityList(
                        labSession: session,
                      )),
            );
          }),
        ]));
  }
}
