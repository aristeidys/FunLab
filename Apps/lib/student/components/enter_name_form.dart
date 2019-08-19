import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/username_reducer.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/student/pages/student_session_search.dart';

class EnterNameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (studentName) =>
          store.dispatch(ReplaceUserNameAction(studentName));
    }, builder: (context, callback) {
      return FormWithButton('Enter your Name', 'Next', (studentName) {
        Student student = Student(name: studentName);
        StudentService().postRequest(student, (success, id) {
          if (success) {
            callback(studentName);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentSessionSearchPage()),
            );
          } else {
            CustomToaster().showToast(
                context, ToasterType.failure, 'Failure Creating User');
          }
        });
      });
    });
  }
}
