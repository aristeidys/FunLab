import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/stateManagment/reducers/classroom_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';
import 'package:funlab/instructor/manage_classroom/manage_classroom.page.dart';

class JoinClassroomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return StoreConnector<AppInstructorState, OnStateChanged>(
              converter: (store) {
            return (classroom) => store.dispatch(SetClassroomAction(classroom));
          }, builder: (context, callback) {
            return FormWithButton('Classroom Name', 'Join Classroom', (name) {
              ClassroomService().getByName(name).then((response) {
                if (response.data != null) {
                  callback(response.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageClassroomPage()),
                  );
                } else {
                  CustomToaster().showToast(context, ToasterType.failure,
                      'Failure joining Classroom. ${response.error}');
                }
              });
            });
          });
        });
  }
}
