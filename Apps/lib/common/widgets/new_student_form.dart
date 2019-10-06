import 'package:flutter/material.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/form_with_button.dart';

class NewStudentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormWithButton('Enter Student Username', 'Create Student', (username) {
      User student = User(username: username);
      StudentService().createStudent(student).then((response) {
        if (response.statusCode == 201) {
          CustomToaster().showToast(context, ToasterType.success,
              'Student Created.');
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Student. ${response.body}');
        }
      });
    });
  }
}
