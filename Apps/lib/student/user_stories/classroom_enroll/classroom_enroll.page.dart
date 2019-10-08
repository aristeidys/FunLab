import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/enrollment.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/services/enrollment.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class ClassroomEnrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Enroll in a Classroom'),
        ),
        body: ClassroomEnrollForm());
  }
}

class ClassroomEnrollForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return FormWithButton('Enter Classroom Name', 'Enroll', (name) {
            ClassroomService().getByName(name).then((response) {
              if (response.data != null) {
                Classroom classroom = response.data;
                var enrollment =
                    Enrollment(classroomID: classroom.id, studentID: user.id);
                EnrollmentService().create(enrollment).then((response) {
                  if (response.data != null) {
                    CustomToaster().showToast(context, ToasterType.success,
                        'Enrolled on $name, wait for approval.');
                  } else {
                    CustomToaster().showToast(context, ToasterType.failure,
                        'Failure Enrolling to Classroom $name');
                  }
                });
              } else {
                CustomToaster().showToast(context, ToasterType.failure,
                    'Failure Finding Classroom $name');
              }
            });
          });
        });
  }
}
