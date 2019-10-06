import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/pages/sign_up.page.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/student/components/find_student_form.dart';
import 'package:funlab/student/pages/student_session_search.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // FindStudentForm(
      //   buttonCallback: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => StudentSessionJoinPage()),
      //     );
      //   },
      // ),
      Center(
        child: Text('Or create new User...'),
      ),
      Center(
          child: EditButton(
        text: 'New User',
        callback: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpPage()));
        },
      )),
    ]);
  }
}
