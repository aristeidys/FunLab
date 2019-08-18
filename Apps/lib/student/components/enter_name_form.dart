import 'package:flutter/material.dart';
import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/student/pages/student_session_search.dart';

class EnterNameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormWithButton('Enter your Name', 'Next', (studentName) {
      Student student =
          Student(name: studentName);
      StudentService().postRequest(student, (success, id) {
        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentSessionSearchPage()),
          );
        } else {
          CustomToaster()
              .showToast(context, ToasterType.failure, 'Failure Creating User');
        }
      });
    });
  }
}
