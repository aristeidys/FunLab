import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/pages/sign_up.page.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/forms/log_in_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
      LogInFormStudentWidget(),
      Center(
        child: Text('Or create new User...'),
      ),
      Center(
          child: EditButton(
        text: 'New User',
        callback: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
      )),
    ]);
  }
}

class LogInFormStudentWidget extends StatelessWidget {
  const LogInFormStudentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LogInForm((email, password) {
      User student = User(username: email, password: password);
      // StudentService().create(student).then((response) {
      //   if (response.statusCode == 201) {
      //     CustomToaster()
      //         .showToast(context, ToasterType.success, 'Student Created.');
      //   } else {
      //     CustomToaster().showToast(context, ToasterType.failure,
      //         'Failure Creating Student. ${response.body}');
      //   }
      // });
    });
  }
}
