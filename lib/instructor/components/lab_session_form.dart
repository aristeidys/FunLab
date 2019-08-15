import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/current_lab_session_Id.dart';
import 'package:funlab/common/services/service.dart';
import 'package:funlab/common/widgets/custom_form.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class LabSessionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (id) => store.dispatch(ReplaceCurrentLabIDAction(id));
    }, builder: (context, callback) {
      return MyCustomForm((labSessionTitle) {
        LabSession session =
            LabSession(title: labSessionTitle, finished: false);
        HttpService<LabSession>().postRequest(session, (success, id) {
          if (success) {
            callback(id);
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
