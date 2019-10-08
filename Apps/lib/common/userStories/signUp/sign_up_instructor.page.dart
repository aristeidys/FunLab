import 'package:flutter/material.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/instructor.service.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/sign_up_form.dart';

class SignUpInstructorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create new Instructor'),
        ),
        body: ListView(
            shrinkWrap: true, children: <Widget>[SignUpStudentFormWidget()]));
  }
}

class SignUpStudentFormWidget extends StatelessWidget {
  const SignUpStudentFormWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignUpForm((name, email, password) {
      User instructor = User(name: name, email: email, password: password);
      InstructorService().create(instructor).then((response) {
        if (response.statusCode == 201) {
          CustomToaster()
              .showToast(context, ToasterType.success, 'Instructor Created.');
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Instructor. ${response.body}');
        }
      });
    });
  }
}
