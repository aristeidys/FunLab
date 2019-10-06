import 'package:flutter/material.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/new_student_form.dart';

class SignUpStudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create new User'),
        ),
        body: Column(children: <Widget>[
          NewStudentForm()
        ]));
  }
}
