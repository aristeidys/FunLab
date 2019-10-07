import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/response.dart';
import 'package:funlab/common/services/instructor.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/stateManagment/reducers/user_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/instructor/pages/instructor_home.dart';
import 'log_in_form.dart';

class InstructorLogInFormWidget extends StatelessWidget {
  const InstructorLogInFormWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, OnStateChanged>(
        converter: (store) {
      return (user) => store.dispatch(SetUserAction(user));
    }, builder: (context, callback) {
      return LogInForm('Login as Instructor', (email, password) {
        InstructorService().getByEmail(email).then((Response<User> result) {
          if (result.data != null) {
            callback(result.data);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructorHomePage()),
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
