import 'package:flutter/material.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/instructor.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class NewInstructorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormWithButton('Enter Instructor Email', 'Create Instructor', (email) {
      User lecturer = User(email: email);
      InstructorService().create(lecturer).then((response) {
        if (response.statusCode == 201) {
          CustomToaster().showToast(context, ToasterType.success,
              'Instructor Created.');
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Instructor. ${response.body}');
        }
      });
    });
  }
}