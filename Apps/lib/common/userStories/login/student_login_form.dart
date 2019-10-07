import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:funlab/common/services/student.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/stateManagment/reducers/activities_reducer.dart';
import 'package:funlab/common/stateManagment/reducers/user_reducer.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/student/user_stories/home/student_home.page.dart';
import 'log_in_form.dart';

class StudentLogInFormWidget extends StatelessWidget {
  const StudentLogInFormWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, OnStateChanged>(
        converter: (store) {
      return (user) => store.dispatch(SetUserAction(user));
    }, builder: (context, callback) {
      return LogInForm('Login as Student', (email, password) {
        StudentService().getByEmail(email).then((Response<User> result) {
          if (result.data != null) {
            callback(result.data);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentHomePage()),
            );
          } else {
            CustomToaster()
                .showToast(context, ToasterType.failure, '${result.error}');
          }
        });
      });
    });
  }
}
