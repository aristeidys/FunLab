import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/special/lab_session.service.dart';
import 'package:funlab/common/stateManagment/app_state.dart';
import 'package:funlab/common/stateManagment/reducers/activities_reducer.dart';
import 'package:funlab/common/stateManagment/reducers/current_lab_session_Id.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class LabSessionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (labSession) =>
          store.dispatch(ReplaceCurrentLabAction(labSession));
    }, builder: (context, callback) {
      return FormWithButton('Enter Session Name', 'Create Draft Session',
          (labSessionTitle) {
        LabSession labSession =
            LabSession(title: labSessionTitle, finished: false, draft: true);
        LabSessionService().postRequest(labSession,
            (success, id, errorMessage) {
          if (success) {
            labSession.id = id;
            callback(labSession);
          } else {
            CustomToaster().showToast(context, ToasterType.failure,
                'Failure Creating Session. $errorMessage');
          }
        });
      });
    });
  }
}
