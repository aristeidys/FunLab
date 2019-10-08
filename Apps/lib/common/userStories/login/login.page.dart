import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/userStories/signUp/sign_up.page.dart';
import 'instructor_login_form.dart';
import 'student_login_form.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(shrinkWrap: true, children: <Widget>[
      StudentLogInFormWidget(),
      InstructorLogInFormWidget(),
      Center(
        child: Text('Or create new User...'),
      ),
      Center(
          child: EditButton(
        'New User',
        () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
      )),
    ]));
  }
}
