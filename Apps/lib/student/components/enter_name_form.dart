import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/username_reducer.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class EnterNameForm extends StatelessWidget {

  final Function buttonCallback;

  EnterNameForm({@required this.buttonCallback});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (studentName) =>
          store.dispatch(ReplaceUserNameAction(studentName));
    }, builder: (context, callback) {
      return FormWithButton('Enter your Name', 'Sign in', (studentName) {
        Student student = Student(name: studentName);
        // StudentService().postRequest(student, (success, id, errorMessage) {
        //   if (success) {
        //     callback(studentName);
        //     buttonCallback();
        //   } else {
        //     CustomToaster().showToast(
        //         context, ToasterType.failure, errorMessage == '' ? 'Failure Creating User' : '$errorMessage');
        //   }
        // });
      });
    });
  }
}
