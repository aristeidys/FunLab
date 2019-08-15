import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/current_lab_session_Id.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/custom_form.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class LabSessionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (labSession) => store.dispatch(ReplaceCurrentLabAction(labSession));
    }, builder: (context, callback) {
      return MyCustomForm((labSessionTitle) {
        LabSession labSession =
            LabSession(title: labSessionTitle, finished: false, draft: true);
        HttpService<LabSession>().postRequest(labSession, (success, id) {
          if (success) {

            labSession.id = id;
            callback(labSession);
            CustomToaster().showToast(
                context, ToasterType.success, 'Session Created Successfully');
          } else {
            CustomToaster().showToast(
                context, ToasterType.failure, 'Failure Creating Session');
          }
        });
      }, 'Enter Session Name');
    });
  }
}
