import 'package:flutter/material.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class ClassroomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormWithButton('Enter Classroom Name', 'Create Classroom', (name) {
      Classroom classroom = Classroom(name: name);
      ClassroomService().create(classroom, 1).then((response) {
        if (response.statusCode == 201) {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Classroom. ${response.body}');
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'Failure Creating Classroom. ${response.body}');
        }
      });
    });
  }
}
