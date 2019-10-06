import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/username_reducer.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class FindStudentForm extends StatelessWidget {

  final Function buttonCallback;

  FindStudentForm({@required this.buttonCallback});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (studentName) =>
          store.dispatch(ReplaceUserNameAction(studentName));
    }, builder: (context, callback) {
      return Column(children: <Widget>[
        // FormWithButton('Username', 'Log in', (studentName) async {
        //   var result =
        //       await StudentService().getStudentsByName(context, studentName);

        //   if (result.length > 0) {
        //     callback(result.first.name);

        //     buttonCallback();
        //   } else {
        //     CustomToaster().showToast(context, ToasterType.failure,
        //         'No Student with name $studentName');
        //   }
        // }),
      ]);
    });
  }
}
