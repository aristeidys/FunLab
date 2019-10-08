import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class ClassroomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return FormWithButton('Enter Classroom Name', 'Create',
              (name) {
            Classroom classroom = Classroom(name: name);
            ClassroomService().create(classroom, user.id).then((response) {
              if (response.data != null) {
                CustomToaster().showToast(context, ToasterType.success,
                    'Successfully Created Classroom.');
              } else {
                CustomToaster().showToast(context, ToasterType.failure,
                    'Failure Creating Classroom. ${response.error}');
              }
            });
          });
        });
  }
}
