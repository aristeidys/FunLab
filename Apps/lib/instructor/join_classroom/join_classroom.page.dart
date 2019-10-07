import 'package:flutter/material.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/instructor/join_classroom/join_classroom_form.dart';

class ClassroomJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create Classroom'),
        ),
        body: Column(children: <Widget>[
          JoinClassroomForm()
        ]));
  }
}
