import 'package:flutter/material.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/new_instructor_form.dart';

class SignUpInstructorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create new Instructor'),
        ),
        body: Column(children: <Widget>[
          NewInstructorForm()
        ]));
  }
}
