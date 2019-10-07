import 'package:flutter/material.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/sign_up_form.dart';

class SignUpStudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create new Student'),
        ),
        body: ListView(
            shrinkWrap: true, children: <Widget>[SignUpStudentWidget()]));
  }
}

class SignUpStudentWidget extends StatelessWidget {
  const SignUpStudentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignUpForm((name, email, password) {
      User student = User(name: name, email: email, password: password);
      StudentService().create(student).then((response) {
        if (response.statusCode == 201) {
          CustomToaster()
              .showToast(context, ToasterType.success, 'Student Created.');
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Student. ${response.body}');
        }
      });
    });
  }
}
