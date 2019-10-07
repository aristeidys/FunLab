import 'package:flutter/material.dart';
import 'package:funlab/common/pages/sign_up_instructor.page.dart';
import 'package:funlab/common/pages/sign_up_student.page.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create new User'),
        ),
        body: Center(
            child: ListView(shrinkWrap: true, children: <Widget>[
          CreateButton(
              'Create new Student',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpStudentPage()),
                  )),
          CreateButton(
              'Create new Instructor',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpInstructorPage()),
                  ))
        ])));
  }
}
