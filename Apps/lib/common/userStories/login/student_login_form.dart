import 'package:flutter/material.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'log_in_form.dart';

class StudentLogInFormWidget extends StatelessWidget {
  const StudentLogInFormWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LogInForm('Login as Student', (email, password) {
      StudentService().getByEmail(email).then((Response<User> result) {
        if (result.data != null) {
          CustomToaster()
              .showToast(context, ToasterType.success, 'Student Found.');
        } else {
          CustomToaster()
              .showToast(context, ToasterType.failure, '${result.error}');
        }
      });
    });
  }
}
